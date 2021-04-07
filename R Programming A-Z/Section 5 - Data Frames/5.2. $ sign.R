# 5.2. Using the $ sign
stats
head(stats)
stats[3,3,drop=F]
stats[3,"Birth.rate",drop=F]
#We cannot use the country name. It is a column, not a name!
#In a data frame, the rows are numbers! Like an Excel!

# $ sign is a way to access data in DATA FRAMES.
# Does NOT WORK in matrices!!!

stats$Internet.users # same as stats[,"Internet.users"]
stats$Internet.users[2]

levels(stats$Income.Group)