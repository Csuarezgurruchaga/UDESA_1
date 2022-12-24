### Calculamos la probabilidad por tcl

p = 0.4
n = 101


### 


medias = replicate(1000, mean(rbinom(n, 1, p)))
par(mfrow = c(1,1))

hist(medias, col = "lightblue", breaks = 20, main = "Replicaciones de la media muestral")
abline(v = 0.38, col = "blue", lty = 3, lwd = 3)
abline(v = 0.42, col = "blue", lty = 3, lwd = 3)

## Contamos que proporción de medias muestrales está entre 0.38 y 0.42
mean( medias >= 0.38 & medias <= 0.42)
## Calculamos la estimación por TCL
pnorm(0.42, mean = p, sd =sqrt( p*(1-p)/n)) - pnorm(0.38, mean = p, sd =sqrt( p*(1-p)/n)) 
