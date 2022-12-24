#### Hierarquical Clustering

setwd("/home/lucas/no-supervisado/practicas/clusterJerarquicos")


library(dendextend)
library(cluster)

### USArrest

data("USArrests")
df = USArrests

## Si las variables tienen escalas muy diferentes pueden afectar a la distancia y por ende al algoritmo jerarquico
boxplot(df)
d = dist(df)
arrest_clust1 = hclust(d, method="complete")
plot(arrest_clust1)

df_stand = scale(df)
d_stand = dist(d)
arrest_clust2 = hclust(d_stand, method="complete")
plot(arrest_clust2)

## Crear dendogramas

# Create two dendrograms
dend1 = as.dendrogram (arrest_clust1)
dend2 = as.dendrogram (arrest_clust2)
# Create a list to hold dendrograms
dend_list <- dendlist(dend1, dend2)

# Comparar dendogramas
tanglegram(dend1, dend2)

tanglegram(dend1, dend2,
           highlight_distinct_edges = FALSE, # Turn-off dashed lines
           common_subtrees_color_lines = FALSE, # Turn-off line colors
           common_subtrees_color_branches = TRUE, # Color common branches
)

#The quality of the alignment of the two trees can be measured using the function
#entanglement(). Entanglement is a measure between 1 (full entanglement) and 0 (no
#entanglement). A lower entanglement coefficient corresponds to a good alignment.


cor.dendlist(dend_list, method = "cophenetic")

# Create multiple dendrograms by chaining
dend1 <- df_stand %>% dist %>% hclust("complete") %>% as.dendrogram
dend2 <- df_stand %>% dist %>% hclust("single") %>% as.dendrogram
dend3 <- df_stand %>% dist %>% hclust("average") %>% as.dendrogram
dend4 <- df_stand %>% dist %>% hclust("centroid") %>% as.dendrogram
# Compute correlation matrix
dend_list <- dendlist("Complete" = dend1, "Single" = dend2,
                      "Average" = dend3, "Centroid" = dend4)
cors <- cor.dendlist(dend_list)
# Print correlation matrix
round(cors, 2)

# Visualize the correlation matrix using corrplot package
library(corrplot)
corrplot(cors, "number", "lower")

library(factoextra)

# dendrograma
fviz_dend(arrest_clust2, k = 4, # Cut in four groups
          cex = 0.5, rect=TRUE, color_labels_by_k = FALSE)#, # label size
          #k_colors = c("#2E9FDF", "#00AFBB", "#E7B800", "#FC4E07"),
          #color_labels_by_k = FALSE, # color labels by groups
          #rect = TRUE, # Add rectangle around groups
          #rect_border = c("#2E9FDF", "#00AFBB", "#E7B800", "#FC4E07"),
          #rect_fill = TRUE)

# version cool
fviz_dend(arrest_clust2, k = 4, k_colors = "jco", type = "circular", repel = TRUE)


## USA MAP CON LOS CLUSTERS

library(usmap)
library(ggplot2)

plot_usmap(regions = "states") + 
  labs(title = "US Counties", subtitle = "This is a blank map of the counties of the United States.") + 
theme(panel.background = element_rect(color = "black", fill = "lightblue"))

plot_usmap(data = uu, values = "pop_2015", color = "red") + 
  scale_fill_continuous(name = "Population (2015)", label = scales::comma) + 
  theme(legend.position = "right")

uu = as.data.frame(statepop)
clusters = rect.hclust(arrest_clust2, k=4)
names(clusters[[1]])
cl_df = data.frame(state=names(clusters[[1]]), clase = rep(1,length(clusters[[1]])))
cl_df = data.frame(rbind(cl_df, data.frame(state=names(clusters[[2]]), clase = rep(2,length(clusters[[2]]))) ) )
cl_df$clase = factor(cl_df$clase)

plot_usmap(data = cl_df, values="clase", color="black") + theme(legend.position = "right")

data("animals")
class(animals)
ma = mona(na.omit(animals), trace.lev=TRUE)
plot(ma)
nrow(na.omit(animals))
ma

data(ruspini)
plot(ruspini)

data(votes.repub)
agn1 <- agnes(votes.repub, metric = "manhattan", stand = TRUE)
agn1
plot(agn1)

op <- par(mfrow=c(2,2))
agn2 <- agnes(daisy(votes.repub), diss = TRUE, method = "complete")
plot(agn2)
## alpha = 0.625 ==> beta = -1/4  is "recommended" by some
agnS <- agnes(votes.repub, method = "flexible", par.meth = 0.625)
plot(agnS)
par(op)
plot(ma)
ma
dian = diana(animals)
plot(dian)
ma$step
table(animals[1,], animals[2,])
print(ma)
ma$order.lab

data(agriculture)
agriculture
plot(diana(agriculture))
pam(agriculture, 2)

