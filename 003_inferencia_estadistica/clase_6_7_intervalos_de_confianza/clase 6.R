## ------------------------------------------
## Generamos 10 valores normales con media 5.
set.seed(1)  # fijamos la semilla
muestra = rnorm(10, mean = 5, sd = 1)


## ------------------------------------------
## Definimos los parametros
nreps = 10000
mu = 0
n = 10
sigma = 0.5
alfa = 0.05


## Calculamos los IC
set.seed(1)
calc_intervalos = function(muestra, sigma, alfa){
  n = length(muestra)
  z = qnorm(1-alfa/2)
  b_izq = mean(muestra) - z*sigma/sqrt(n)
  b_der = mean(muestra) + z*sigma/sqrt(n)
  return(c(b_izq, b_der))
}

muestra = rnorm(10, 0, 0.5)

intervalos = matrix (rep(0, 2*nreps), ncol = 2)

n = 200

for (iter in 1:nreps){
  
    muestra = rnorm(n, mu, sigma)
    intervalos[iter, ] =calc_intervalos(muestra, sd(muestra), alfa)
}


## Proporcion que el IC contiene al mu verdadero
mean((mu< intervalos[,2]) & (mu> intervalos[,1]))
## ------------------------------------------





## ------------------------------------------
## T de student
grados = c(1, 4, 7, 12)
grilla = seq(-5, 5, length = 1000)
curvas = sapply(grados, dt, x=grilla)
matplot(grilla, curvas, type = 'l')
legend("topright", paste("g= ", grados),
       lty = 1:4, col = 1:4)
## ------------------------------------------

## ------------------------------------------
## Parametros
n = 3
mu = 10
sigma = 2
N = 1000
TT = rep(0,N)
## Medias muestrales estandarizadas
for(i in 1:N){
    muestra = rnorm(n, mu, sigma)
    xbarra = mean(muestra)
    s = sd(muestra)
    TT[i] = (xbarra-mu)/(s/sqrt(n))}

## Grafico (histograma T)
hist(TT, freq = FALSE, nclass = 100,
     xlim = c(-5, 5), ylim = c(0, 0.4))
curve(dt(x, n-1), add = TRUE)
curve(dnorm(x), add = TRUE, col = 'red')
## ------------------------------------------

## ------------------------------------------
nreps = 10000
mu = 0
n = 10
sig = 0.5
alfa = 0.05

calc_intervalos_t = function(muestra, alfa){ ## completar funcion
  n = length(muestra)
  t = qt(1-alfa/2, n-1)    
  b_izq = mean(muestra) - t*sd(muestra)/sqrt(n)
  b_der = mean(muestra) + t*sd(muestra)/sqrt(n)
  return(c(b_izq, b_der))
}

intervalos = matrix (rep(0, 2*nreps), ncol = 2)

set.seed(1)
for (iter in 1:nreps) {
    
    muestra = rnorm(n, mu, sigma)
    intervalos[iter, ] =calc_intervalos_t(muestra, alfa)
}
## ------------------------------------------

## ------------------------------------------
# SI MI MUESTRA NO SIGUE UNA DISTRIBUCION NORMAL
set.seed(123)
ns = c(5, 10,20, 25, 30, 35, 40, 45, 50, 100, 200, 400)
cobertura = rep(0, length(ns))
mu = 0.5# 1/lambda

for (k in 1:length(ns)){
  
  n = ns[k]
  
  for (iter in 1:nreps) {
    
    muestra = rexp(n,2)
    intervalos[iter, ] = calc_intervalos_t(muestra, alfa)
  }
  cobertura[k] = mean((mu< intervalos[,2]) & (mu> intervalos[,1]))

}

plot(ns, cobertura, col = "blue", main = "CONFIANZA USANDO UNA DISTRIBUCION EXP",
                                  ylim = c(0.88, 0.96), xlab = "CANTIDAD DE MUESTRAS",
                                  ylab = "NIVEL DE CONFIANZA EMPIRICO")
abline(h = 0.95, col = "red", lwd = 2)
## ------------------------------------------


## ------------------------------------------
## La proporcion de veces que contiene a mu
mean((mu< intervalos[,2]) & (mu> intervalos[,1]))




## En R:  
prop.test(340, 500)
##          1-sample proportions test with continuity correction
##          data:  340 out of 500, null probability 0.5
##          X-squared = 64.082, df = 1, p-value = 1.193e-15
##          alternative hypothesis: true p is not equal to 0.5
##          95 percent confidence interval:
##          0.6368473 0.7203411
##          sample estimates:
##             p
##          0.68
## ------------------------------------------



