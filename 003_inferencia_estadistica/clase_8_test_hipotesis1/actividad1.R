
estadistico1 = function(muestra){
  mean(muestra)
}

estadistico2 = function(muestra){
  sum( muestra <= 3 )
}

n = 40
#Item 3
muestra = sample(1:6, n, replace = TRUE)
estadistico1(muestra)
estadistico2(muestra)

estadisticos1 = replicate(1000 , estadistico1(sample(1:6, n, replace = TRUE)))
estadisticos2 = replicate(1000 , estadistico2(sample(1:6, n, replace = TRUE)))

hist(estadisticos1, freq = FALSE)
hist(estadisticos2, freq = FALSE)
points(5:25, dbinom(5:25, n, 0.5), col = "red")

qbinom(0.975, n, 0.5)
qbinom(0.025, n, 0.5)
#region de rechazo es Menor que 8 o mayor que 17

(sum(estadisticos2 > 20) + sum(estadisticos2 < 10))/1000

qbinom(0.9, n, 0.5)
qbinom(0.95, n, 0.5)


estamuchos = replicate( 1000, estadistico2( sample(1:6, 25, replace = TRUE, c(rep(0.1, 5), 0.5))))

mean(estamuchos >=17)
hist(estamuchos)
