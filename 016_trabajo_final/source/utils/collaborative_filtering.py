import pandas as pd
import numpy as np
from tqdm import tqdm
from scipy.spatial.distance import pdist, squareform


def leave_one_last_item(df, uid_col_name, proportion_test_items=0.1):
    """
    Splits a DataFrame into a test set containing a proportion of the last items for each user and a training set.

    Parameters:
        df (pd.DataFrame): The input DataFrame containing ratings data.
        uid_col_name (str): The name of the column representing user IDs.
        proportion_test_items (float, optional): The proportion of last items to include in the test set. Default is 10%.

    Returns:
        train (pd.DataFrame): DataFrame for training, containing all the items that are not in test.
        test (pd.DataFrame): DataFrame for testing, containing the last proportion_test_items items for each user.
    """

    test = pd.DataFrame()

    for _, data_by_user in df.groupby(uid_col_name):
        n_test_items = int(df.shape[0]*proportion_test_items)
        test = pd.concat([test, data_by_user.iloc[-n_test_items:]])

    train = df[~df.index.isin(test.index)]
    
    return train, test

    


def adjusted_cosine_similarity(user_item_matrix, itemA, itemB, min_overlap = 5):
    """
    Calculate the adjusted cosine similarity of the items for a user-item matrix.

    Parameters:
    - user_item_matrix (numpy.ndarray): Matrix representing user-item interactions,
                                        where rows are users and columns are items.
    - itemA (int): itemA to calculate the similarity agains itemB.
    - itemB (int): itemB to calculate the similarity agains itemA.
    - min_overlap(int): Min value of overlapping between items to perform the calculation.

    Returns:
    - items_similarity_matrix (numpy.ndarray): Adjusted cosine similarity matrix of the items.
    """

    if type(user_item_matrix) != np.ndarray:
        user_item_matrix = user_item_matrix.to_numpy()
    
    mu_users = np.nanmean(user_item_matrix, axis = 1)
    
    result = np.concatenate((user_item_matrix[:, [itemA]], user_item_matrix[:, [itemB]]), axis=1)
    
    normalized = result - mu_users[:, None]
    non_nan_mask = ~np.any(np.isnan(normalized), axis=1)
    normalized_2 = normalized[non_nan_mask]
    if normalized_2.shape[0] > min_overlap:#pido un minimo valor de overlap entre items
        items_similarity_scalar = 1 - pdist(normalized_2.T, 'cosine')
        return items_similarity_scalar[0]
    # items_similarity_scalar = 1 - pdist(normalized_2.T, 'cosine')
    # return items_similarity_scalar[0]




def compute_item_similarity(user_item_matrix):
    """
    Computes item similarity based on the adjusted cosine similarity metric using the 
    Amazon technic described in his paper.

    Parameters:
    - user_item_matrix (numpy.ndarray): A 2D matrix representing user-item interactions,
      where rows correspond to users, and columns correspond to items. The values
      indicate user-item interactions (e.g., purchase history or ratings for movies).

    Returns:
    - dict: A nested dictionary representing item similarity. The outer dictionary
      has item indices as keys, and the associated values are inner dictionaries.
      Inner dictionaries have other item indices as keys and adjusted cosine similarity
      values as values.

    Note:
    - The adjusted cosine similarity is computed for each pair of items based on the
      user-item matrix. Similarity is calculated only if at least one user has interacted
      with both items.
    - The negative values of similarity are ignored.
    """
    
    if type(user_item_matrix) != np.ndarray:
        user_item_matrix = user_item_matrix.to_numpy()
    
    num_items = user_item_matrix.shape[1]
    similarity_dict = {}
    
    for item1 in tqdm(range(num_items), desc="Computing Similarities", unit="item"):
    # for item1 in range(1, num_items+1):#si quiero q arranque desde item 0, en vez de 1 como esta en el dataset
        similarity_dict[item1] = {}
        for item2 in range(num_items):
        # for item2 in range(1, num_items+1):#si quiero q arranque desde item 0, en vez de 1 como esta en el dataset
            # the customer purchased both items?
            # if np.any(np.logical_and(user_item_matrix[:, item1-1], user_item_matrix[:, item2-1])): #si quiero q arranque desde item 0, en vez de 1 como esta en el dataset
            if np.any(np.logical_and(user_item_matrix[:, item1], user_item_matrix[:, item2])): 
                
                # calculate the adjusted cosine similarity between the two items
                # similarity_scalar, _ = adjusted_cosine_similarity(user_item_matrix, item1-1, item2-1) #si quiero q arranque desde item 0, en vez de 1 como esta en el dataset
                similarity = adjusted_cosine_similarity(user_item_matrix, item1, item2) 
                
                # we consider only the positive values of similarity
                if similarity is not None and similarity >= 0:
                    similarity_dict[item1][item2] = similarity
                    
    #sort the dict with the values of similarity
    sorted_sim_dict = {k: {inner_key: inner_value for inner_key, inner_value in sorted(v.items(), key=lambda item: item[1], reverse=True) 
                           if inner_key != k} for k, v in similarity_dict.items()}

    return sorted_sim_dict



def compute_neighbors(u, i, user_item_matrix, sim, n_neighbors=5):
    """
    Compute the top neighbors of item i for a given user u based on item similarity.

    Parameters:
    - u: User index
    - i: Item index for which neighbors are to be computed
    - sim: Dictionary of the similarity between items
    - n_neighbors: Number of neighbors to retrieve (default is 5)
    - user_item_matrix: User-item interaction matrix

    Returns:
    - neighbors_of_i: Dictionary containing the top neighbors of item i for user u
    """
    
    sim_keys = sim[i].keys()
    # Intersection of keys in similaridades[i] and user_item_matrix
    j = list(set(sim_keys) & set(list(user_item_matrix.loc[u, :].dropna().index)))
    # Create a dictionary with keys from j and values from similaridades[i]
    sorted_similarities = {k: sim[i][k] for k in j}
    # Sort the dictionary based on values in descending order
    sorted_similarities = dict(sorted(sorted_similarities.items(), key=lambda x: x[1], reverse=True))
    # Select the top neighbors values from the sorted dictionary
    neighbors_of_i = dict(list(sorted_similarities.items())[:n_neighbors])
    
    return neighbors_of_i