#3.1. Vectors
MyFirstVector <- c(3,45,56,732)
is.numeric(MyFirstVector) # TRUE
is.integer(MyFirstVector) # FALSE
is.double(MyFirstVector) # TRUE

V2 <- c(3L,12L,243L,0L)
is.numeric(V2) # TRUE
is.integer(V2) # TRUE
is.double(V2) # FALSE

v3 <- c("a","B23","Hello", 7)
is.character(v3) # TRUE
is.numeric(v3) # FALSE

#seq() # Sequence Function
#rep() # Replicate function

seq(1,15) # Same as 1:15
seq(1,15,2) # Step of 2
z <- seq(1,15,4)
z

rep(3,50) # Replicates 3 50 times
d <- rep(3,50)
d

rep("a",5)

x <- c(80,20)
x
y <- rep(x,10)
y
