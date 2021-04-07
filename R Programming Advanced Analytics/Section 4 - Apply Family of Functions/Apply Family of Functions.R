# "Apply" family of functions

# Deliverables
# 1. A table showing the annual averages of each observed metric for every city
# 2. A table showing by how much temperature fluctuates each month from min to
#    max (in %). Take min temperature as the base
# This is the difference between max and min, using min as base
# (max-min)/min
# 3. A table showing the annual maximums of each observed metric for every city
# 4. A table showing the annual minimums of each observed metric for every city
# 5. A table showing in which months the annual maximums of each metric were
#    observed in every city (Advanced)


library(ggplot2)

# ----------------------------------------------------------------------------
# Load Data
getwd()
setwd("C:\\Users\\Daniel.Inacio\\Desktop\\R Programming Advanced Analytics\\Section 4 - Apply Family of Functions\\P3-Weather-Data")

# If you load without row names, the first column is taken as data!
# Chicago <- read.csv("Chicago-C.csv")
Chicago <- read.csv("Chicago-C.csv",row.names = 1,
                    stringsAsFactors = TRUE,
                    na.strings = c(""))

Houston <- read.csv("Houston-C.csv",row.names = 1,
                    stringsAsFactors = TRUE,
                    na.strings = c(""))

NewYork <- read.csv("NewYork-C.csv",row.names = 1,
                    stringsAsFactors = TRUE,
                    na.strings = c(""))

SanFrancisco <- read.csv("SanFrancisco-C.csv",row.names = 1,
                         stringsAsFactors = TRUE,
                         na.strings = c(""))

# Initial Analysis
is.data.frame(Chicago)
head(Chicago)
str(Chicago)
summary(Chicago)

# Because ALL elements are numeric (same type), we will work with matrices
# Convert dataframe to matrix
Chicago <- as.matrix(Chicago)
Houston <- as.matrix(Houston)
NewYork <- as.matrix(NewYork)
SanFrancisco <- as.matrix(SanFrancisco)

is.matrix(Chicago)

# Create the list Weather (with names included)
Weather = list(Chicago=Chicago,
               Houston=Houston,
               NewYork=NewYork,
               SanFrancisco=SanFrancisco)
Weather[3]
Weather$NewYork

# apply(M,1,mean) -> Applies the mean() function to all rows of matrix M
#                    i.e., a matrix M with 3 rows would return 3 means
# apply(M,2,mean) -> Applies the mean() function to all columns of matrix M
#                    i.e., a matrix M with 5 columns would return 5 means

# ----------------------------------------------------------------------------
# Using apply()
?apply()

# Averages
apply(Chicago,1,mean)
mean(Chicago["AvgHigh_C",]) # Check

apply(Houston,1,mean)
mean(Houston["AvgHigh_C",]) # Check

apply(NewYork,1,mean)
mean(NewYork["AvgHigh_C",]) # Check

apply(SanFrancisco,1,mean)
mean(SanFrancisco["AvgHigh_C",]) # Check
# Close to deliverable 1, but can be improved

# Maximums
apply(Chicago,1,max)
max(Chicago["AvgHigh_C",]) # Check

apply(Houston,1,max)
max(Houston["AvgHigh_C",]) # Check

apply(NewYork,1,max)
max(NewYork["AvgHigh_C",]) # Check

apply(SanFrancisco,1,max)
max(SanFrancisco["AvgHigh_C",]) # Check

# Minimums
apply(Chicago,1,min)
min(Chicago["AvgHigh_C",]) # Check

apply(Houston,1,min)
min(Houston["AvgHigh_C",]) # Check

apply(NewYork,1,min)
min(NewYork["AvgHigh_C",]) # Check

apply(SanFrancisco,1,min)
min(SanFrancisco["AvgHigh_C",]) # Check

# We could cbind() to bind these averages, mins and maxs
# to get the final result, but there is a faster way

# ----------------------------------------------------------------------------
# DO NOT USE! Recreating apply() with loops
output <- NULL
for(i in 1:5)
{
  output[i] <- mean(Chicago[i,])
}
names(output) <- rownames(Chicago)
output
# Too long
rm(i,output)

# ----------------------------------------------------------------------------
# Using lapply() - For lists or vectors
?lapply()

# Example 1: Transposing a matrix and transposing a list
Chicago
t(Chicago)

Weather # Too long
t(Weather$Chicago)
t(Weather$Houston)
t(Weather$NewYork)
t(Weather$SanFrancisco)

# CORRECT WAY
lapply(Weather,t)
t_Weather <- lapply(Weather,t)

# Example 2: Adding a new row to all matrices of a list
rbind(Chicago,NewRow=1:12)
Chicago

lapply(Weather,rbind,NewRow=1:12)

# Example 3: Applying rowMeans to a list
?rowMeans()
rowMeans(Chicago,na.rm=TRUE) # identical to apply(Chicago,1,mean)

lapply(Weather,rowMeans)
# Close to deliverable 1, but can be improved

#rowMeans
#colMeans
#rowSums
#colSums

# ----------------------------------------------------------------------------
# Combining lapply() with []
Weather

# January High Average for Chicago
Weather$Chicago[1,1]

# Example 1: January High Average for ALL FOUR CITIES
# Wrong
Weather$Chicago[1,1]
Weather$Houston[1,1]
Weather$NewYork[1,1]
Weather$SanFrancisco[1,1]

# CORRECT WAY
lapply(Weather,"[",1,1)

# Example 2: First row for an entire list
Weather$Chicago[1,]
lapply(Weather,"[",1,)

# Example 3: List with all averages from March from all cities
Weather$Chicago[,3]
list(Weather$Chicago[,3],
     Weather$Houston[,3],
     Weather$NewYork[,3],
     Weather$SanFrancisco[,3])

lapply(Weather,"[",,3)

# ----------------------------------------------------------------------------
# Adding your own functions
lapply(Weather,function(x) x[1,])  # Fetching the first row of each matrix
lapply(Weather,function(x) x[5,])  # Fetching the hours of sunshine
lapply(Weather,function(x) x[,12]) # Fetching December data

Weather$Chicago
lapply(Weather,function(z) z[1,]-z[2,]) # Diff between AvgHigh and AvgLow
lapply(Weather,function(z) (z[1,]-z[2,])/abs(z[2,]))
lapply(Weather,function(z) round((z[1,]-z[2,])/abs(z[2,]),2))
# Deliverable 2: Temperature fluctuations between max and min, with min as base
# Can be better

# ----------------------------------------------------------------------------
# Using sapply()
?sapply()
sapply(Weather,function(z) round((z[1,]-z[2,])/abs(z[2,]),2))

# AvgHigh for July
Weather$Chicago[1,7]
lapply(Weather,"[",1,7)
sapply(Weather,"[",1,7)

# AvgHigh for 4th Quarter
Weather$Chicago[1,10:12]
lapply(Weather,"[",1,10:12)
sapply(Weather,"[",1,10:12)

# Yearly Averages (rowMeans)
rowMeans(Weather$Chicago)
lapply(Weather,rowMeans)
sapply(Weather,rowMeans)
DL1 <- round(sapply(Weather,rowMeans),2)
# DELIVERABLE 1 COMPLETE!!!
write.csv(DL1,"C:\\Users\\Daniel.Inacio\\Desktop\\R Programming Advanced Analytics\\Section 4 - Apply Family of Functions\\DL1.csv")

# Temperature Fluctuations
DL2 <- sapply(Weather,function(z) round((z[1,]-z[2,])/abs(z[2,]),2))
# DELIVERABLE 2 COMPLETE!!!
write.csv(DL2,"C:\\Users\\Daniel.Inacio\\Desktop\\R Programming Advanced Analytics\\Section 4 - Apply Family of Functions\\DL2.csv")

# By the way:
sapply(Weather,rowMeans,simplify = FALSE) # Returns lapply()

# ----------------------------------------------------------------------------
# Nesting apply() functions

# How would you get the max values in the list?

# For one dataframe
max(Weather$Chicago[1,])
apply(Weather$Chicago,1,max)

sapply(Weather,max) # Max of everything, not per row!

# For the whole list
lapply(Weather, function(city) apply(city,1,max))
sapply(Weather, function(city) apply(city,1,max))
DL3 <- sapply(Weather, apply,1,max) # Simpler
# DELIVERABLE 3 COMPLETE!!!
write.csv(DL3,"C:\\Users\\Daniel.Inacio\\Desktop\\R Programming Advanced Analytics\\Section 4 - Apply Family of Functions\\DL3.csv")


# How would you get the min values in the list?
lapply(Weather, function(city) apply(city,1,min))
sapply(Weather, function(city) apply(city,1,min))
DL4 <- sapply(Weather, apply,1,min) # Simpler
# DELIVERABLE 4 COMPLETE!!!
write.csv(DL4,"C:\\Users\\Daniel.Inacio\\Desktop\\R Programming Advanced Analytics\\Section 4 - Apply Family of Functions\\DL4.csv")

# ----------------------------------------------------------------------------
# which.max() and which.min()
?which.max()
Weather$Chicago[1,]
which.max(Weather$Chicago[1,])
which.min(Weather$Chicago[1,])
names(which.max(Weather$Chicago[1,])) # To get names instead of numbers

# apply() to iterate for every row
apply(Weather$Chicago,1,which.max) # Only returns the first true value!
# If you want names
apply(Weather$Chicago,1,function(x) names(which.max(x)))

# lapply() for the whole list (max and min)
lapply(Weather,apply,1,which.max)
sapply(Weather,apply,1,which.max)

lapply(Weather,apply,1,which.min)
sapply(Weather,apply,1,which.min)

# If you want names, copy the whole previous function
lapply(Weather,function(city) apply(city,1,function(x) names(which.max(x))))
DL5 <- sapply(Weather,function(city) apply(city,1,function(x) names(which.max(x))))
# DELIVERABLE 5 COMPLETE!!!
write.csv(DL5,"C:\\Users\\Daniel.Inacio\\Desktop\\R Programming Advanced Analytics\\Section 4 - Apply Family of Functions\\DL5.csv")

lapply(Weather,function(city) apply(city,1,function(x) names(which.min(x))))
DL6 <- sapply(Weather,function(city) apply(city,1,function(x) names(which.min(x))))
# DELIVERABLE 6 COMPLETE!!!
write.csv(DL6,"C:\\Users\\Daniel.Inacio\\Desktop\\R Programming Advanced Analytics\\Section 4 - Apply Family of Functions\\DL6.csv")