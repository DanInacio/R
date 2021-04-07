#4.2. ColNames and RowNames
Charlie <- 1:5

#Give Names
names(Charlie) <- c("a","b","c","d","e")
Charlie
Charlie["d"]
names(Charlie)

#Clear Names
names(Charlie) <- NULL

rm(Charlie)

# ------------------

# Naming Matrix Dimensions 1
temp.vec <- rep(c("a","B","zZ"),times=3)
temp.vec2 <- rep(c("a","B","zZ"),each=3)
temp.vec
temp.vec2

Bravo <- matrix(data=temp.vec2,nrow=3,ncol=3,byrow=FALSE)
Bravo

rownames(Bravo) <- c("Row 1","Row 2","Row 3")
colnames(Bravo) <- c("Col 1","Col 2","Col 3")
Bravo

Bravo["Row 2","Col 2"] <- 0
Bravo

rownames(Bravo) <- NULL
colnames(Bravo) <- NULL
Bravo

rm(temp.vec,temp.vec2,Bravo)