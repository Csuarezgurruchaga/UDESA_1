data <- read.table("~/Desktop/UDESA/003_inferencia_estadistica/clase_4/Clase 4-20220528/gamma-arrivals.csv", quote="\"", comment.char="")

muestra = data$V1
summary(muestra)


momentos = function(muestra){
  lambda_hat = mean(muestra)/(mean(muestra^2) - mean(muestra)^2)
  alfa_hat =  mean(muestra)^2/(mean(muestra^2) - mean(muestra)^2)
  c(alfa_hat, lambda_hat)
}


mlog.likelihood = function(muestra, par){
  alfa = par[1]
  lambda = par[2]
  -(sum( alfa*log(lambda) - log(gamma(alfa)) + (alfa - 1)*log(muestra) - lambda*muestra)) 
  #definimos menos el loglikelihood porque optim minimiza
  #ponemos el parametro "par", ya que la funcion optim, necesita que le ingresemos
  #en modo de vector los parametros de la funcion a optimizar.
}

mlog.likelihood(muestra, momentos(muestra))

EMV = function(muestra){ #optim necesita un punto inicial. Usamos el estimador de momentos
  optim(par = momentos(muestra), mlog.likelihood, muestra = muestra)$par  
}

(mom_gamma = momentos(muestra))
(mle_gamma = EMV(muestra))

hist(muestra, breaks = 20, col = "steelblue", freq = FALSE)
curve(dgamma(x, shape = mom_gamma[1], rate = mom_gamma[2]),
      min(muestra), max(muestra), add = TRUE, col = "red", lwd = 2)
curve(dgamma(x, shape = mle_gamma[1], rate = mle_gamma[2]),
      min(muestra), max(muestra), add = TRUE, col = "orange", lwd = 2, lty = 3)

##### 

muestral_emv = replicate(2000, EMV(rgamma(20,shape = 2, rate = 0.5)))
muestral_mom = replicate(2000, momentos(rgamma(20,shape = 2, rate = 0.5)))


hist(muestral_emv[1,], col = rgb(0,0,1,1/4), breaks = 20, main = "Histograma alfa_hat")
hist(muestral_mom[1,], col = rgb(1,0,0,1/4), add = T, breaks = 20)
abline( v = 2, col = "red", lty = 3)
legend("topright", fill = c(rgb(0,0,1,1/4), rgb(1,0,0,1/4)), legend = c("Emv", "Momentos"))

hist(muestral_emv[2,], col = rgb(0,0,1,1/4), breaks = 20, main = "Histograma lambda_hat")
hist(muestral_mom[2,], col = rgb(1,0,0,1/4), add = T, breaks = 20)
abline( v = 0.5, col = "red", lty = 3)
legend("topright", fill = c(rgb(0,0,1,1/4), rgb(1,0,0,1/4)), legend = c("Emv", "Momentos"))

##### BOOTSTRAP
Nboot = 1000
n = length(muestra)


mle_boot_par = matrix( rep(0, 2*Nboot), ncol = 2) #bootstrap parametrico
mom_boot_par = matrix( rep(0, 2*Nboot), ncol = 2)
mle_boot_res = matrix( rep(0, 2*Nboot), ncol = 2)# bootstrap resampleo
mom_boot_res = matrix( rep(0, 2*Nboot), ncol = 2)

for (k in 1:Nboot){
  
  mle_boot_par[k,] = EMV(rgamma(n, shape = mle_gamma[1], rate = mle_gamma[2]))
  mom_boot_par[k,] = momentos(rgamma(n, shape = mom_gamma[1], rate = mom_gamma[2]))
  mle_boot_res[k,] = EMV(sample(muestra, replace = TRUE))
  mom_boot_res[k,] = momentos(sample(muestra, replace = TRUE))
}

#hist(mle_boot_par[,2], col = rgb(0,0,1,1/4), freq = FALSE, xlim = c(0.01, 0.015))
#hist(mom_boot_par[,2], col = rgb(1,0,0,1/4), add = T, freq = FALSE)

#Ahora busco estimar el desvio
apply(mle_boot_par, 2, sd)
apply(mom_boot_par, 2, sd)

apply(mle_boot_res, 2, sd)
apply(mom_boot_res, 2, sd)
# En este caso dieron muy parecidos, ya que la muestra que tengo es bastante grande
# En casos con pocos datos, conviene mas hacer el bootstrap parametrico


# Ahora busco estimar el sesgo
apply(mle_boot_res, 2, mean) - mle_gamma # En mle_gamma, tengo los valores estimados por metodo de MVS
apply(mle_boot_par, 2, mean) - mom_gamma # En mom_gamma, tengo los valores estimados por metodo de momento
