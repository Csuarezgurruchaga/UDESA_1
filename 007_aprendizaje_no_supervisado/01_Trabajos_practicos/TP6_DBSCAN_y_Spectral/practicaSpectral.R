### SPECTRAL CLUSTERING

## Libreria
library(kernlab) # permite ademas utilizar un nucleo en la disimilaridad

### EJEMPLO DE PRUEBA
data(spirals)
plot(spirals)  

sc = specc(spirals, centers=2, kernel = "rbfdot") # nucleo gaussiano
sc #lista con objetos entre ellos los clusters
centers(sc); sc@centers # dos opciones para acceder los centros
size(sc) # tamaño de los clusters 
withinss(sc) # variabilidad intra-cluster 
sc@.Data # etiquetas de clusters para cada dato

plot(spirals, col=sc, pch=20)
points(centers(sc)[1,1], centers(sc)[1,2], pch=15, cex=1.5, col="black")
points(centers(sc)[2,1], centers(sc)[2,2], pch=15, cex=1.5, col="red")


### EJERCICIO PARA HACER EN CLASE

#1. Comparar el resultado que arrojaria dbscan para "spirals" 
#2. Comparar la permonce de ambos metodos para "multishapes" (utilizar en numero de clusters en specc que considere adecuado)
#3. Observar como funciona specc con banknote



# epsilon - vecindad

lg = function(d, epsilon) {
  d = as.matrix(d)
  n = nrow(d)
  W = matrix(0,nrow=n, ncol=n)
  for (i in 1:n) {
    for (j in 1:n) {
      if (d[i,j] < epsilon) W[i,j] = d[i,j] else W[i,j] = 0
    }
  }
  W2 = (1/2)*(W+t(W)) 
  grado = apply(W,2,sum)
  D = diag(grado)
  L = D - W
  return(L)
}



L = lg(dist(spirals), 0.18)
n = nrow(L)
auto_L = eigen(L)
plot(auto_L$values, pch=20)
U = auto_L$vectors[,1:2]
plot(U, col=sc)
abline(h=0, lty=2, col="lightgrey")
abline(v=0, lty=2, col="lightgrey")

auto_L$values
