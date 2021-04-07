#4.5. Subsetting
x <- c("a","b","c","d","e")
x[1:3]
x[c(1,5)]

rm(x)

#Top 3 players in the last 5 years
Games[1:3,6:10]
#Best and Worst Player
Games[c(1,10),]
#All Players for 2 years
Games[,c("2008","2009")]

# If you want a 1-dim matrix, that is a vector!
Games[1,]
is.matrix(Games[1,]) # FALSE
is.vector(Games[1,]) # TRUE

Games[1,,drop=FALSE]
is.matrix(Games[1,,drop=FALSE]) # TRUE, now it does not drop dimensions
Games[1,5,drop=FALSE]