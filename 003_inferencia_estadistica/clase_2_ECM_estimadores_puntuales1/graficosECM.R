ecm_p13 = function(n, p){ return(p*(1-p)/n) }
ecm_p2 = function(n, p){ ((2/n-4*p/n)/(1+4/n))^2+n*p*(1-p)/((n+4)^2)}

p = seq(0,1, by = 0.05)
par(mfrow = c(1,2))
plot(p, ecm_p13(2,p), col = "lightseagreen", type = "l", lwd = 2.5, 
                   ylab = "ECM", main = "n = 5")
lines(p, ecm_p13(5,p ), col = "steelblue1", lwd = 2.5)
lines(p, ecm_p2(5,p ), col = "darkorange1", lwd = 2.5)

plot(p, ecm_p13(100,p), col = "steelblue1", type = "l", lwd = 2.5, 
                     ylab = "ECM", main = "n = 100")
lines(p, ecm_p2(100,p ), col = "darkorange1", lwd = 2.5)
