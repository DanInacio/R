library(ggplot2)

# Load Data
getwd()
setwd("C:\\Users\\Daniel.Inacio\\Desktop\\R Programming Advanced Analytics\\Section 2 - Data Preparation")

# Basic Input
# futureDF <- read.csv("P3-Future-500-The-Dataset.csv",
#                      stringsAsFactors = TRUE)

# New Input (after realising the NA vs. empty cell issue)
futureDF <- read.csv("P3-Future-500-The-Dataset.csv",
                     stringsAsFactors = TRUE,
                     na.strings = c(""))

# Initial Analysis
head(futureDF)
tail(futureDF)
str(futureDF)
summary(futureDF)

# Factors (refresher)
# Looking at the data, ID does not need to be an int, it can be a factor
# Same for year (no need for min, max, median, etc.)

# On the other hand, revenue, expenses and profit, should be numbers!

# Convert to factors
futureDF$ID <- factor(futureDF$ID)
futureDF$Inception <- factor(futureDF$Inception)

str(futureDF)

# ----------------------------------------------------------------------------
# FVT: Factor Variable Trap (can happen when converting to Non-Factor)

# CHARACTERS INTO NUMERICS
a <- c("12","13","14","12","12")
typeof(a) # Character type, str() is for DATA FRAMES
# If I wanted numeric
b <- as.numeric(a)
typeof(b) # Double type

# FACTORS INTO NUMERICS
z <- factor(a)
z
typeof(z) # The integer type is not the content, it is the factor levels
y <- as.numeric(z)
y # Lost the data!!! Only got the factor levels!
typeof(y)

# Converting factor into numbers will simply return the factor levels!!!

# CORRECT WAY TO CONVERT FACTORS INTO NUMERIC
# Factor > Char > Numeric
x <- as.numeric(as.character(z))
x
typeof(x)

# ----------------------------------------------------------------------------
# FVT Example - DANGEROUS
#str(futureDF)

# Turn profit into a factor
#futureDF$Profit <- factor(futureDF$Profit)
#str(futureDF)

# If you turn it into numeric, FVT!
#as.numeric(futureDF$Profit)

# ----------------------------------------------------------------------------
# gsub() and sub()
str(futureDF)

# Revenue, Expenses and Growth should be numeric
# But we must remove some characters from that data!

# These are find/replace functions
# gsub() for all instances, sub() for the first instance

futureDF$Expenses <- gsub(" Dollars","",futureDF$Expenses)
futureDF$Expenses <- gsub(",","",futureDF$Expenses)
head(futureDF)
str(futureDF) # Expenses is now of char type

futureDF$Revenue <- gsub("\\$","",futureDF$Revenue)
futureDF$Revenue <- gsub(",","",futureDF$Revenue)
head(futureDF)
str(futureDF) # Revenue is now of char type

futureDF$Growth <- gsub("%","",futureDF$Growth)
head(futureDF)
str(futureDF) # Growth is now of char type

# Finally, make them numeric
futureDF$Expenses <- as.numeric(futureDF$Expenses)
futureDF$Revenue <- as.numeric(futureDF$Revenue)
futureDF$Growth <- as.numeric(futureDF$Growth)
str(futureDF)

# If you check a summary, look at NA's
summary(futureDF)

# ----------------------------------------------------------------------------
# Dealing with missing data
# 1. Predict with 100% accuracy (as if you never had missing data)
# 2. Ignore (if it is not important for your analysis)
# 3. Remove record entirely (may reduce your data significance)
# 4. Replace with mean or median (popular approach!)
# 5. Fill in by exploring correlations, regressions, similarities
# 6. Introduce dummy variable for "Missingness"

# Look at .csv for examples on how to approach

# ----------------------------------------------------------------------------
# NA
summary(futureDF)
?NA

TRUE  # 1
FALSE # 0
NA    # No value - data is missing!

TRUE == TRUE   # true
TRUE == 5      # false
TRUE == 1      # true

FALSE == FALSE # true
FALSE == 5     # false
FALSE == 0     # true

NA == TRUE     # NA
NA == FALSE    # NA
NA == 15       # NA
NA == NA       # NA

# NA - data is missing. You CANNOT compare it!

# ----------------------------------------------------------------------------
# Locating Missing Data!
head(futureDF,25)
# Notice NA, blanks, <NA>

# Returns a vector of complete rows (TRUE/FALSE)
complete.cases(futureDF)

# As a filter, this will return all rows without NA's
# (will still contain empty data, just not the NA's)
futureDF[complete.cases(futureDF),]

# We want the opposite. Just the NA's
# Not all empty rows are returned. Just the NA ones.
futureDF[!complete.cases(futureDF),]

# The simplest way is at the top of the code!
# When importing the data, fill empty cells with NA!
# futureDF <- read.csv("P3-Future-500-The-Dataset.csv",
#                      stringsAsFactors = TRUE,
#                      na.strings = c(""))
str(futureDF)

# ----------------------------------------------------------------------------
# Filtering: using which() for non-missing data
head(futureDF)

# How to find a single value?
futureDF[3,"Revenue"]          # Value
# OR
futureDF$Revenue == 9746272    # Vector TRUE/FALSE

futureDF[futureDF$Revenue == 9746272,]
# Why is it returning the correct row AND full NA rows???
# Because this filter returns TRUE and NA rows (where Revenue is NA)

# It could pass all the other correct values of the rows and the revenue as NA
# True, but that would imply the whole row passed the filter test!

# To sum up filtering returns TRUE and NA values and its rows
head(futureDF)
futureDF[futureDF$Revenue == 9746272,]

# To filter only the non-missing data:
?which() # Which indices are true?
which(futureDF$Revenue == 9746272) # Returns 3
futureDF[which(futureDF$Revenue == 9746272),]

# Another example
head(futureDF)
futureDF[futureDF$Employees == 45,]
futureDF[which(futureDF$Employees == 45),]

# ----------------------------------------------------------------------------
# Filtering: using is.na() for non-missing data
futureDF[!complete.cases(futureDF),]

# This returns all rows with NA
# What if I want rows where Expenses is NA?
# futureDF[futureDF$Expenses == NA,]
# You are comparing data with NA. The result is NA for everything

# CORRECT WAY
is.na(futureDF$Expenses)
futureDF[is.na(futureDF$Expenses),]

# Another Example
is.na(futureDF$State)
futureDF[is.na(futureDF$State),]

# ----------------------------------------------------------------------------
# Removing records with missing data

# Which records can we remove?
# Industry - cannot be empty and we cannot research it
# Inception - NOT to remove. We will leave it empty!

# BACKUP so we don't need to run the whole code so far
futureDF_backup <- futureDF
#futureDF <- futureDF_backup

futureDF[!complete.cases(futureDF),]
futureDF[is.na(futureDF$Industry),] # Which rows have Industry as NA

futureDF[!is.na(futureDF$Industry),] # All the rows EXCEPT industry as NA
futureDF <- futureDF[!is.na(futureDF$Industry),]

# ----------------------------------------------------------------------------
# Resetting the Dataframe Index
head(futureDF,20)
tail(futureDF)
# Notice the ID still shows some rows have been removed!
# Also 500, instead of 498 rows!

rownames(futureDF) # Shows current row names
nrow(futureDF)     # Shows number of rows

# ONE WAY
rownames(futureDF) <- 1:nrow(futureDF)

head(futureDF,20)
tail(futureDF)

# FASTER WAY
rownames(futureDF) <- NULL

# ----------------------------------------------------------------------------
# Replacing Missing Data: Factual Analysis
futureDF[!complete.cases(futureDF),]

# State can be filled in with 100% certainty
futureDF[is.na(futureDF$State),]

futureDF[is.na(futureDF$State) & futureDF$City == "New York",]
futureDF[is.na(futureDF$State) & futureDF$City == "New York","State"] <- "NY"
futureDF[c(11,377),] # Check

futureDF[is.na(futureDF$State) & futureDF$City == "San Francisco",]
futureDF[is.na(futureDF$State) & futureDF$City == "San Francisco","State"] <- "CA"
futureDF[c(82,265),] # Check

futureDF[!complete.cases(futureDF),]
# ----------------------------------------------------------------------------
# Replacing Missing Data: Median Imputation Method (Part 1)
# Employees
futureDF[is.na(futureDF$Employees),]

# Get median
medianEmployeeRetail <- median(futureDF[!is.na(futureDF$Employees) & futureDF$Industry == "Retail","Employees"])
# OR
median(futureDF[futureDF$Industry == "Retail","Employees"],na.rm=TRUE)

# Assign median to empty cells
# Find rows for Retail where Employees is NA and assign the value
futureDF[is.na(futureDF$Employees) & futureDF$Industry == "Retail",]
futureDF[is.na(futureDF$Employees) & futureDF$Industry == "Retail","Employees"] <- medianEmployeeRetail
futureDF[3,] # Check

# Financial Services
futureDF[is.na(futureDF$Employees),]

# Get median
medianEmployeeFinancial <- median(futureDF[futureDF$Industry == "Financial Services","Employees"],na.rm=TRUE)

# Assign median
futureDF[is.na(futureDF$Employees) & futureDF$Industry == "Financial Services","Employees"] <- medianEmployeeFinancial

futureDF[330,] # Check

# ----------------------------------------------------------------------------
# Replacing Missing Data: Median Imputation Method (Part 2 and 3)
futureDF[!complete.cases(futureDF),]

# Growth

# Get median
median(futureDF[futureDF$Industry == "Construction","Growth"],na.rm=TRUE)
medianGrowthConstruction <- median(futureDF[futureDF$Industry == "Construction","Growth"],na.rm=TRUE)

# BONUS: median of an entire column without filters
# median(futureDF$Growth,na.rm=TRUE)
# OR
# median(futureDF[,"Growth"],na.rm=TRUE)

# Assign median
futureDF[is.na(futureDF$Growth) & futureDF$Industry == "Construction","Growth"] <- medianGrowthConstruction
futureDF[8,] # Check

# Revenue

# Get median
medianRevenueConstruction <- median(futureDF[futureDF$Industry == "Construction","Revenue"],na.rm=TRUE)
# Assign median
futureDF[is.na(futureDF$Revenue) & futureDF$Industry == "Construction","Revenue"] <- medianRevenueConstruction
futureDF[c(8,42),] # Check

futureDF[!complete.cases(futureDF),]

# Expenses (only if profit is also NA!)

# Get median
medianExpensesConstruction <- median(futureDF[futureDF$Industry == "Construction","Expenses"],na.rm=TRUE)
# Assign median
futureDF[is.na(futureDF$Expenses) & 
           is.na(futureDF$Profit) & futureDF$Industry == "Construction","Expenses"] <- medianExpensesConstruction
futureDF[c(8,42),] # Check

futureDF[!complete.cases(futureDF),]

# ----------------------------------------------------------------------------
# Replacing Missing Data: Deriving Values Method

# Revenue-Expenses=Profit
futureDF[is.na(futureDF$Profit),]
futureDF[is.na(futureDF$Profit),"Profit"] <- futureDF[is.na(futureDF$Profit),"Revenue"] -
                                             futureDF[is.na(futureDF$Profit),"Expenses"]
futureDF[c(8,42),] # Check
futureDF[!complete.cases(futureDF),]

# Revenue-Profit=Expenses
futureDF[is.na(futureDF$Expenses),]
futureDF[is.na(futureDF$Expenses),"Expenses"] <- futureDF[is.na(futureDF$Expenses),"Revenue"] -
  futureDF[is.na(futureDF$Expenses),"Profit"]

futureDF[15,] # Check
futureDF[!complete.cases(futureDF),]

# We will leave Inception as NA since it won't affect our analysis
finalDF <- futureDF
finalDF[!complete.cases(finalDF),]

# ----------------------------------------------------------------------------
# Visualizing Results

# Scatterplot, classified by industry, showing revenue, expenses, profit
p <- ggplot(data=finalDF) +
  geom_point(aes(x=Revenue,y=Expenses,
                 colour=Industry,size=Profit))
p

# Scatterplot, showing industry trends for expenses-revenue relationship
q <- ggplot(data=finalDF,aes(x=Revenue,y=Expenses,
                             colour=Industry)) +
  geom_point() +
  geom_smooth(fill=NA,size=1.2)
q

# Boxplots for growth in industry
r <- ggplot(data=finalDF,aes(x=Industry,y=Growth,
                             colour=Industry)) +
  geom_jitter() +
  geom_boxplot(aes(fill=Industry),colour="Black",
               size=0.5,alpha=0.7,outlier.colour = NA)
r
