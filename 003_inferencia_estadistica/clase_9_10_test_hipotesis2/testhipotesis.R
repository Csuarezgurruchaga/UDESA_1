BodyTemp50

temperaturas = BodyTemp50$BodyTemp


qt(0.975, 50-1)
qnorm(0.975)

T = (mean(temperaturas)-98.6)/sqrt(var(temperaturas)/50)

grupo1 = temperaturas[BodyTemp50$Sex == 1]
grupo0 = temperaturas[BodyTemp50$Sex == 0]

W = (mean(grupo1) - mean(grupo0) - 0)/sqrt(var(grupo1)/length(grupo1) + var(grupo0)/length(grupo0))


# Rechazo si |Wobs| >= qnorm(1-0.1/2)
qnorm(0.95)
W

#pvalor: P( |W| > |Wobs|) bajo H0
2*pnorm(-0.81021)

t.test(grupo1, grupo0)
