data <- read.csv("~/Desktop/UDESA/003_inferencia_estadistica/clase_4/Clase 4-20220528/faithful.csv")

muestra = faithful$eruptions

hist(muestra, col = "steelblue", main ="Faithful")


(mediana = median(muestra))

Nboot = 1000
n = length(muestra)


m_boot = rep(0, Nboot) # aca voy a guardar las realizaciones de la muestra bootstrap

for (k in 1:Nboot) {
  muestra_boot = sample(muestra, replace = TRUE)
  m_boot[k] = median(muestra_boot)
}

#calculo los parametros de la distribucion del estimador
mean(m_boot)
sd(m_boot)
quantile(m_boot, c(0.1, 0.9))


# ¿Como puedo estimar la probabilidad de que la mediana sea mayor a 60?
mean(m_boot > 60)


# ¿Cómo puedo estimar el sesgo de la mediana? y el ECM?

sesgo = median(m_boot) - median(muestra) # mediana del estimador menos mediana de la muestra
ECM = var(m_boot) + sesgo ^ 2 
