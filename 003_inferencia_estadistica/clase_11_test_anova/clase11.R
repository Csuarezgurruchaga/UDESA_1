muestra = rnorm(9, 67, sd = sqrt(100))

test_var_desconocida = function(muestra){ 
  W = (mean(muestra) - 68)*sqrt(length(muestra))/sd(muestra)
  return(W)
}

test_var_conocida = function(muestra){ 
  W = (mean(muestra) - 68)*sqrt(length(muestra))/10
  return(W)
}

test_var_desconocida(muestra)

qt(0.975, df = 9-1)

### Generando 1000 muestras del estadistico con mu = 67 y sigma = raiz(100)
replicaciones = replicate(10000, test_var_desconocida(rnorm(9, 64, sqrt(100))))
replicaciones2 = replicate(10000, test_var_conocida(rnorm(9, 64, sqrt(100))))
## Proporciòn de rechazos
mean(abs(replicaciones)>qt(0.975, df = 9-1))
mean(abs(replicaciones2)>qnorm(0.975))

### Estimar la potencia sobre una grilla de valores
medias_verdaderas = seq(60, 76, by = 0.5)
potencia_var_desconocido = rep(0, length(medias_verdaderas))
potencia_var_conocido = rep(0, length(medias_verdaderas))

for (i  in 1:length(medias_verdaderas)){
  replicaciones = replicate(1000, test_var_desconocida(rnorm(9, medias_verdaderas[i], sqrt(100))))
  replicaciones2 = replicate(1000, test_var_conocida(rnorm(9, medias_verdaderas[i], sqrt(100))))
  potencia_var_desconocido[i] = mean(abs(replicaciones)>qt(0.975, df = 9-1))
  potencia_var_conocido[i] = mean(abs(replicaciones2)>qnorm(0.975))
}
potencia_var_conocido
potencia_var_desconocido

plot(medias_verdaderas, potencia_var_desconocido, ylim =c(0.05, 0.7), type = "l", col = "blue", lwd = 3)
lines(medias_verdaderas, potencia_var_conocido, col = "orange", lwd = 3)
