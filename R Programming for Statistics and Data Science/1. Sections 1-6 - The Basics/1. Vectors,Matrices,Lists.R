# ----------------------------------------------------------------------------
# Exercise 1: Creating Objects in R
x <- 10:20
y <- x +2
z <- y*3
answer <- (z-6)/3

# One line of code
x <- (((10:20) + 2)*3 - 6)/3

# ----------------------------------------------------------------------------
# Exercise 2: Data Types in R
cards <- c("Blue-Eyes White Dragon","Exodius",
           "The Winged Dragon of Ra","Raigeki",
           "Slifer the Sky Dragon","Obelisk the Tormentor",
           "Black Luster Soldier","5-Headed Dragon",
           "Exodia the Forbidden One","Dragon Master Knight")
typeof(cards)

atk <- c(3000,NA,NA,NA,NA,4000,3000,5000,1000,5000)
typeof(atk)

yugioh <- c(cards,atk)
yugioh

# ----------------------------------------------------------------------------
# Exercise 3: Coercion Rules in R
monster <- c(T,T,T,F,T,T,T,T,T,T)
yugioh <- c(yugioh,monster)
yugioh # monster is of logical type

coerce.check <- c(atk,monster)
coerce.check # monster is of integer type

# String > Integer > Logical

# ----------------------------------------------------------------------------
# Exercise 4: Using Functions in R
lvl <- c(8,10,10,1,10,10,8,12,1,12)

sum(lvl)
mean(lvl)
median(lvl)
length(lvl)
sd(lvl)
round(sd(lvl),2)
print(round(sd(lvl),2))

# ----------------------------------------------------------------------------
# Exercise 5: Arguments of a Function
?sample()
?median()

median(lvl,na.rm=TRUE)
median(atk)
median(atk,na.rm=TRUE)

# ----------------------------------------------------------------------------
# Exercise 6: Building a function in R

# Cheating Coin Flip
draw <- function(){
  coin <- c("Heads","Tails")
  prob.vector <- c(0.7,0.3)
  sample(coin,size=100,replace=TRUE,prob=prob.vector)
}

draw()

# ----------------------------------------------------------------------------
# Exercise 7: Vector Recycling
weight <- c(71,67,83,67)
height <- c(1.75,1.81,1.78,1.82,1.97,2.12,2.75)

BMI <- weight/(height^2)
BMI

# ----------------------------------------------------------------------------
# Exercise 8: Naming Vectors in R
names(atk) <- c("Blue-Eyes White Dragon","Exodius",
                "The Winged Dragon of Ra","Raigeki",
                "Slifer the Sky Dragon","Obelisk the Tormentor",
                "Black Luster Soldier","5-Headed Dragon",
                "Exodia the Forbidden One","Dragon Master Knight")
atk
attributes(atk)

# names(atk) <- NULL
# atk

# You can also name when creating the vector!

# ----------------------------------------------------------------------------
# Exercise 9: Indexing and Slicing a Vector
atk[6]
atk[-2]
atk[c(1,3,5,7,9)]
atk[-(4:6)]
atk[atk>2000]

# ----------------------------------------------------------------------------
# Exercise 10: Vector Attributes - Dimensions
s <- seq(from=2,to=30,by=2)
attributes(s) # None

dim(s) <- c(3,5)
s

attributes(s)

# ----------------------------------------------------------------------------
# Exercise 11: Creating a matrix in R
player <- c(rep("dark",5), rep("light",5))
piece <- c("king","queen","pawn","pawn","knight",
           "bishop","king","rook","pawn","pawn")
chess <- c(player,piece)
chess

# Method 1: dim()
?dim()
dim(chess) <- c(10,2)
colnames(chess) <- c("Player","Piece")
chess

# Method 2: matrix()
?matrix()
matrix(data=chess,nrow=10,ncol=2,byrow=FALSE,
       dimnames=list(NULL,c("Player","Piece")))

# Method 3: cbind()
?cbind()
cbind("Player"=player,"Piece"=piece)

# ----------------------------------------------------------------------------
# Exercise 12: Indexing and Slicing a Matrix
chess <- rbind(t(chess),"Turn"=c(3,5,2,2,7,4,6,5,2,1))
chess
chess <- t(chess)
chess

chess[6,2] # Element
chess[,"Player"] # Column
chess[,"Piece"]  # Column
chess[1:5,] # All info on "dark"
chess[,"Piece",drop=FALSE] # Extract and keep as matrix
chess[,-2] # All but "Piece"
chess[2,c(1,3)] # 1st and 3rd elements in 2nd row
chess[7,3] <- 3 # Replace an element
chess

# ----------------------------------------------------------------------------
# Exercise 13: Matrix Arithmetic
?runif()
?matrix()
randomMatrix <- matrix(data=runif(12),nrow=3,ncol=4,byrow=TRUE)
colnames(randomMatrix) <- c("Uno","Dos","Tres","Cuatro")
rownames(randomMatrix) <- c("x","y","z")
randomMatrix

randomMatrix <- randomMatrix*10
randomMatrix

subMatrix <- randomMatrix[1:2,1:4]
subMatrix
randomMatrix-subMatrix # Fails. Inadequate sizes

subMatrix <- randomMatrix[1:3,1:3]
randomMatrix-subMatrix # Fails. Inadequate sizes

uno <- randomMatrix[,"Uno"]
uno
randomMatrix-uno # Works!

# Recycling applies when operations are done with a matrix and a vector!
# NOT with two matrices!!!

# Now with rnorm()
?rnorm()
rMatrix <- matrix(rnorm(12),nrow=3,ncol=4)
rMatrix

randomMatrix*rMatrix # 3x4 * 3x4

# Inner Matrix Multiplication (algebraic)
randomMatrix%*%t(rMatrix)

# ----------------------------------------------------------------------------
# Exercise 14: Matrix Operations
n <- matrix(rnorm(15),nrow=5,ncol=5,byrow=TRUE)
u <- matrix(runif(15),nrow=5,ncol=5,byrow=TRUE)

totalCol_n <- colSums(n)
avgCol_n <- colMeans(n)
totalCol_u <- colSums(u)
avgCol_u <- colMeans(u)

n <- rbind(n,totalCol_n,avgCol_n)
u <- rbind(u,totalCol_u,avgCol_u)

totalRow_n <- rowSums(n)
avgRow_n <- rowMeans(n)
totalRow_u <- rowSums(u)
avgRow_u <- rowMeans(u)

n <- cbind(n,totalRow_n,avgRow_n)
u <- cbind(u,totalRow_u,avgRow_u)

min(n)
min(u)
max(n)
max(u)

min(n[,3])
min(u[,3])
max(n[,3])
max(u[,3])

mean(n)
mean(u)
sd(n)
sd(u)
# Data generated with rnorm() will always have an sd close to 1,
# because this is how the function is defined to work
# rnorm() generates data with default settings mean=0, standard deviation = 1 

# runif() generates data within the [0, 1] range

# ----------------------------------------------------------------------------
# Exercise 15: Creating a factor in R
player <- c(rep("dark",5), rep("light",5))
piece <- c("king","queen","pawn","pawn","knight",
           "bishop","king","rook","pawn","pawn")
chess <- c(player,piece)
chess
chess.mat <- matrix(data=chess,nrow=10,ncol=2,byrow=FALSE,
                    dimnames=list(NULL,c("Player","Piece")))

piece_vec <- chess.mat[,"Piece"]
piece_factor <- factor(piece_vec)

# Labelling without ordering
piece_factor <- factor(piece_vec,
                       levels = c("king","queen",
                                  "rook","bishop",
                                  "knight","pawn"),
                       labels = c("King","Queen",
                                  "Rook","Bishop",
                                  "Knight","Pawn"))

# Labelling with ordering
levels(piece_factor) <- c("Ki","Q","R","B","Kn","P")
piece_ordered <- factor(piece_factor,ordered=TRUE,
                        levels = c("Ki","Q","R","B","Kn","P"),
                        labels = c("King","Queen",
                                   "Rook","Bishop",
                                   "Knight","Pawn"))

# ----------------------------------------------------------------------------
# Exercise 16: Lists in R
l <- list(Numbers=c(1,3,5,7,9,11),Phrases=list("Happy Birthday","Archery"))
l

l[[1]]
l[[2]][1]
l[[2]][2]
l[2]
l[1]
l[[1]]+2

l$Brands <- c("Kellogs","Nike","IPhone")
l

l$Brands <- NULL

# ----------------------------------------------------------------------------
# Exercise 17: Logical Operators
# Explain the difference between | , || , & and &&

# Answer:
# Single operators (|, &) can return a vector

((-2:2) >= 0) & ((-2:2) <= 0)
# FALSE FALSE  TRUE FALSE FALSE

# Double operators (||, &&) return a single value
((-2:2) >= 0) && ((-2:2) <= 0)
# FALSE

# ----------------------------------------------------------------------------
# Exercise 18: If, Else, Else If
number <- -1
if((number >= 1) & (number < 60)){
  print("Rotten!")
  
} else if((number >= 60) & (number < 75)){
  print("Fresh!")
  
} else if((number >= 75) & (number <+ 100)){
  print("Certified Fresh!")
  
} else
  print("Please input a number between 1 and 100")

# Another One
lottery <- round(runif(6,min=1,max=50),0)

myTry <- c(7,39,20,24,35,32)

if(length(myTry) != 6){
  print("Invalid ticket. Choose 6 values")
  
} else{
  if(length(setdiff(myTry,lottery)) == 0){
    print("Congrats!")
    
  } else
    print("Lost...")
}

# ----------------------------------------------------------------------------
# Exercise 19: For/While/Repeat Loops in R
n <- 10
result <- 0

for(i in 1:n){
  result <- result + 1
}

# ----

n <- 0
result <- 0

while(n < 10){
  result <- result + 1
  n <- n+1
}

# ----

#n <- 0
#result <- 0

#repeat{
  
#  if(){
#    break
#  }
  
#}

# ----------------------------------------------------------------------------
# Exercise 20: Functions 2.0
draw <- function(){
  coin <- c("Heads","Tails")
  prob.vector <- c(0.7,0.3)
  sample(coin,size=100,replace=TRUE,prob=prob.vector)
}