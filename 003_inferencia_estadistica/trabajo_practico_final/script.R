## experimentación anova

escenario1 = function(mus, J){
  desvio1 = sqrt(3)
  desvio2 = sqrt(3)
  desvio3 = sqrt(3)
  
  grupos = cbind(mus[1] + rnorm(J, 0, desvio1), # El comando cbind junta columnas
                 mus[2] + rnorm(J, 0, desvio2),
                 mus[3] + rnorm(J, 0, desvio3))
}

escenario5 = function(mus, dep){
  J = 20
  desvio1 = 1
  desvio2 = 1
  desvio3 = 1
  base_err = rnorm(J, 0, sd = 1)
  
  grupos = cbind(mus[1] + rnorm(J, 0, desvio1*sqrt(1-dep)) + base_err*sqrt(dep),
                 mus[2] + rnorm(J, 0, desvio2*sqrt(1-dep)) + base_err*sqrt(dep),
                 mus[3] + rnorm(J, 0, desvio3*sqrt(1-dep)) + base_err*sqrt(dep))
}

SStot = function(muestra){
  sum((muestra - mean(muestra))^2)
}

SSw = function(muestra){
  
  #SStot(muestra[,1]) + SStot(muestra[,2]) + ... + SStot(muestra[,I])
  sum(apply(muestra, 2, SStot))

}

SSb = function(muestra){
  J = nrow(muestra)
  media_tot = mean(muestra)
  J*(sum((colMeans(muestra) - media_tot)^2 ))
}



