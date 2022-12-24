#### Generación de una muestra de Bernoullis y calculo de la media muestral

n = 10 # Tamaño de la muestra (personas encuestadas)
p_verdadero = 0.65 # Probabilidad verdadera de exito 
                   #(Esta uno no la suele conocer pero la fijamos para poder sortear los datos)


muestra = rbinom(n = n, size = 1, prob = p_verdadero) #Sorteamos 10 bernoulis con prob = p_verdadero
names(muestra) = paste( " x", 1:n, sep = "")  #Le ponemos nombre a las muestras para que quede mas lindo (no es necesario)
muestra
mean(muestra)

cant = 0

cant = cant +1

muestra = rbinom(n = n, size = 1, prob = p_verdadero) #Sorteamos 10 bernoulis con prob = p_verdadero
names(muestra) = paste( " x", 1:n, sep = "")  #Le ponemos nombre a las muestras para que quede mas lindo (no es necesario)

media_muestral = mean(muestra) #Calculamos el promedio de la muestra

paste( "La", cant, "muestra obtuvo los siguientes valores")
muestra
paste("La media muestral es:", media_muestral)


#¿Por qué cambia la media muestral cada vez que volvemos a encuestar gente?

#### ¿Que pasa si hicieramos muchas encuestas a 20 personas?

n = 20
p_verdadero = 0.5

muestra = rbinom(n = n, size =1  , prob = p_verdadero)
names(muestra) = paste( " x", 1:n, sep = "")
muestra

medias = replicate(reps, mean(rbinom(n =n, size = 1, prob = p_verdadero)))
names(medias) = paste( " M", 1:reps, sep = "") #Esto tampoco es necesario pero se entiede mas al leer.

reps = 5 # Cantidad de encuestas que realizamos a n personas.
medias          
medias = replicate(reps, mean(rbinom(n =n, size = 1, prob = p_verdadero)))
names(medias) = paste( " M", 1:reps, sep = "") #Esto tampoco es necesario pero se entiede mas al leer.
medias


# Y si hicieramos 1000 encuestas?

reps = 1000
medias = replicate(reps, mean(rbinom(n =n, size = 1, prob = p_verdadero)))
names(medias) = paste( " M", 1:reps, sep = "") #Esto tampoco es necesario pero se entiede mas al leer.
medias

# ¿Como podemos ver toda esta información?

hist(medias, col = "steelblue", freq = TRUE,
            xlim = c(0,1),
            main = paste( "Histograma para la media muestral de n =", n, "y  p = ", p_verdadero),
            xlab = "Medias muestrales",
            lwd = 3,
            density = 60)
abline(v = p_verdadero, lwd = 2, pch = 3, col = "blue", lty = 3)



##### Que pasa si cambiamos el parametro p_verdadero?

p_verdadero = 0.2 # Cambiamos el parametro

medias = replicate(reps, mean(rbinom(n =n, size = 1, prob = p_verdadero)))

hist(medias, col = "steelblue", freq = TRUE,
     main = paste( "Histograma para la media muestral de n =", n, "y  p = ", p_verdadero),
     xlab = "Medias muestrales",
     xlim = c(0,1),
     lwd = 3,
     density = 60)
abline(v = p_verdadero, lwd = 2, pch = 3, col = "blue", lty = 3)


p_verdadero = 0.9 # Cambiamos el parametro

medias = replicate(reps, mean(rbinom(n =n, size = 1, prob = p_verdadero)))

# ¿Como podemos ver toda esta información?

hist(medias, col = "steelblue", freq = TRUE,
     main = paste( "Histograma para la media muestral de n =", n, "y  p = ", p_verdadero),
     xlab = "Medias muestrales",
     xlim = c(0,1),
     lwd = 3,
     density = 60)
abline(v = p_verdadero, lwd = 2, pch = 3, col = "blue", lty = 3)


##### Que pasa si aumentamos el tamaño de la muestra y mantenemos el p fijo?

p_verdadero = 0.5 # Cambiamos el parametro
n = 20
medias = replicate(reps, mean(rbinom(n =n, size = 1, prob = p_verdadero)))

hist(medias, col = "steelblue", freq = TRUE,
     main = paste( "Histograma para la media muestral de n =", n, "y  p = ", p_verdadero),
     xlab = "Medias muestrales",
     xlim = c(0,1),
     lwd = 3,
     density = 60)
abline(v = p_verdadero, lwd = 2, pch = 3, col = "blue", lty = 3)

n = 40

medias = replicate(reps, mean(rbinom(n =n, size = 1, prob = p_verdadero)))

hist(medias, col = "steelblue", freq = TRUE,
     main = paste( "Histograma para la media muestral de n =", n, "y  p = ", p_verdadero),
     xlab = "Medias muestrales",
     xlim = c(0,1),
     lwd = 3,
     density = 60)
abline(v = p_verdadero, lwd = 2, pch = 3, col = "blue", lty = 3)

n = 80

medias = replicate(reps, mean(rbinom(n =n, size = 1, prob = p_verdadero)))

hist(medias, col = "steelblue", freq = TRUE,
     main = paste( "Histograma para la media muestral de n =", n, "y  p = ", p_verdadero),
     xlab = "Medias muestrales",
     xlim = c(0,1),
     lwd = 3,
     density = 60)
abline(v = p_verdadero, lwd = 2, pch = 3, col = "blue", lty = 3)

## Vamos a hacer esto de una forma un poco mas automatica...

par(mfrow = c(2,3)) #Seteamos 2 filas y 3 columnas de graficos

ns = c(20, 40, 100, 200, 400,1000)
ns
for(n in ns){ #Hacemos las siguientes acciones para cada n en el vector ns
  
  
  medias = replicate(reps, mean(rbinom(n =n, size = 1, prob = p_verdadero)))
  
  hist(medias, col = "steelblue", freq = TRUE,
       main = paste( "Histograma para la media muestral de n =", n, "y  p = ", p_verdadero),
       xlab = "Medias muestrales",
       xlim = c(0,1),
       lwd = 3,
       density = 60)
  abline(v = p_verdadero, lwd = 2, pch = 3, col = "blue", lty = 3)
  
}


### Ley de los grandes numeros



par(mfrow = c(2,3)) #Seteamos 2 filas y 3 columnas de graficos

ns = c(20, 40, 100, 200, 400,1000)
ns
lambda_verdadero = 2 # De vuelta este lo elegimos para poder simular.
for(n in ns){ #Hacemos las siguientes acciones para cada n en el vector ns
  
  
  medias = replicate(reps, mean(rpois(n =n, lambda = lambda_verdadero)))
  
  hist(medias, col = "steelblue", freq = TRUE,
       main = paste( "Histograma para la media muestral de n =", n, "y  lambda = ", lambda_verdadero),
       xlab = "Medias muestrales",
       xlim = c(1,3),
       lwd = 3,
       density = 60)
  abline(v = lambda_verdadero, lwd = 2, pch = 3, col = "blue", lty = 3)
  
}

### Teorema centra del limite



par(mfrow = c(2,3)) #Seteamos 2 filas y 3 columnas de graficos

ns = c(20, 40, 100, 200, 400,1000)
ns
lambda_verdadero = 2 # De vuelta este lo elegimos para poder simular.
for(n in ns){ #Hacemos las siguientes acciones para cada n en el vector ns

  medias = replicate(reps, mean(rpois(n =n, lambda = lambda_verdadero)))
  media_estandarizada = sqrt(n)*(medias - lambda_verdadero)/sqrt(lambda_verdadero)
  hist(media_estandarizada, col = "steelblue", freq = TRUE,
       main = paste( "Histograma para la media muestral estandarizada de n =", n, "y  lambda = ", lambda_verdadero),
       xlab = "Medias muestrales",
       xlim = c(-4,4),
       lwd = 3,
       density = 60)
  abline(v = 0, lwd = 2, pch = 3, col = "blue", lty = 3)
  
}
