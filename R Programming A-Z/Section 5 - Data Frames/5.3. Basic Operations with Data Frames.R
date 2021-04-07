#5.3. Basic Operations with Data Frames

stats[1:10,] #Subsetting
stats[1,]
is.data.frame(stats[1,])

stats[,1,drop=F]
is.data.frame(stats[,1,drop=F])
# Dimensions only drop when extracting columns in a data frame!!!

#Math operations with columns
head(stats)
stats$Birth.rate*stats$Internet.users # No point but it's possible

#Adding a column
stats$MyCalc <- stats$Birth.rate*stats$Internet.users
stats

#Removing a column
stats$MyCalc <- NULL
stats