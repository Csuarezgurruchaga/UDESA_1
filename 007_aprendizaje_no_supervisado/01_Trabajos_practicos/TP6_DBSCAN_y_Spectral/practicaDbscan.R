#### EJERCICIO DBSCAN

## Librerias para dbscan
library(fpc)
library(dbscan)

### EJEMPLO DE PRUEBA
library(factoextra)
data("multishapes")
# write.csv(multishapes, "multishapes.csv")

plot(multishapes[,1:2])

## Libreria fpc (opcional probar la otra libreria)
scan_fpc = dbscan(multishapes[,1:2], eps = 0.15, MinPts = 2)
scan_fpc #lista con objetos entre ellos los clusters

# Seleccionar el esp: knndist
kNNdist(multishapes, k = 2) # calcula las distancias al 4to vecino mas cercano sin ordenar
kNNdistplot(multishapes, k =  2) # hace el plot con las distancias ordenadas de menos a mayor 
abline(h=0.15, lty=2)

plot(multishapes[,1:2], col=scan_fpc$cluster)

### EJERCICIO PARA HACER EN CLASE

# Utilizar el dataset "banknote.txt" 
# Algunas notas de cambio son falsas con lo cual pueden diferir un poco de las verdaderas. 
# Lucas mezclo los subindices y perdio las etiquetas antes de empezar la clase. 
# Utilizar bdscan para encontrarlas.

