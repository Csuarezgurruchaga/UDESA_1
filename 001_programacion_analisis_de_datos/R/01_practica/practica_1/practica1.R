#b<-3 #asignamos el valor 3 a la variable b
b=3
b<-3
3->b

d=2*b
d

b+d
b*d
b/d

b<-hola
b='hola'

x=c(1,4)
y=c(6,9,12,412)
z=seq(1,1223,1)
w=seq(0.1,422.7,0.1)
length(w)
w[154]
w[154]=2.4
w[154]
w[seq(124,162,1)]
#hacer hasta el ejercicio 15
s=rbind(x+w)
s
t=w[-124]
s=y[c(1,4,3,2)]
y<-scan()

y=c(6,9,12,16)
x=seq(1L,10L,1L)
x
y=seq(101L,110L,1)
y
x+y
x/y
plot(x,y)
a=seq(1,10,1)
b=seq(1,5,1)
a+b
x=seq(1L,10L,1L)
x*x
x^2
q=c(1:4227)
q/10

x=c(a=1,b=2,c=3)
x=c(1:3);names(x)<-c("a","b","c")
x<-setNames(1:3,c('a','b','c'))
letters
LETTERS
length(letters)
length(LETTERS)
paste(letters[1],letters[2],sep="")
paste(letters[1],letters[2],sep=" ")
print('Hola')
a=paste('Me','Encanta','R','!', sep=" ")
print(a)
vector = c('mesa','silla','mantel')
vector[]
sample(c(1:5),3,replace = T)
sample(c(1:5),3,replace = F)
sample(c(1:100),6,replace=F)
sample(c(letters),2)
vector=sample(c(LETTERS),4)
paste(vector,collapse="")

vector1=sample(c(LETTERS),4)
vector2=sample(c(1:9),4)
vector3 = paste(vector1,vector2, colapse='')
orden = sample(c(1:4),4,replace=F)
vector3[orden] 
vector3

vector=c('a','b','c')
vector
paste(vector,collapse='')
paste(vector,sep='')
paste(vector[1],vector[2],vector[3],sep='')

normal = rnorm(1000,12,2) # rnorm(n, mean = 0, sd = 1)
uniforme = runif(1000,3,8)

hist(normal) #hist(distance, main = "Frequency histogram") # Frequency

hist(uniforme)

plot(normal)
plot(uniforme)

x<-c(1,2,3,4)
typeof(x);class(x)

x[2]='dos'
x
class(x)

x<-c("1","2","3","4")
class(x)
x<-as.numeric(x)
class(x)
x<-as.character(x)
class(x)

x<- vector()
x
x[1]='a'
x[2]='b'
x

