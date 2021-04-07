#4.1. Matrices
#?matrix()
matrix.data <- 1:20
A<-matrix(data=matrix.data,nrow=4,ncol=5,byrow=FALSE,dimnames=NULL)
A
A[2,3]

B<-matrix(data=matrix.data,nrow=5,ncol=4,byrow=TRUE,dimnames=NULL)
B
B[3,2]

rm(matrix.data,A,B)

#?rbind()
r1 <- c("I","am","happy")
r2 <- c("What", "a", "day")
r3 <- c(1,2,3)
C <- rbind(r1,r2,r3)
C

rm(r1,r2,r3,C)

#?cbind()
D <-cbind(r1,r2,r3)
D

rm(r1,r2,r3,D)
