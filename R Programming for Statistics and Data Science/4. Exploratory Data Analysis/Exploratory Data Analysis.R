library(tidyverse)
#install.packages("psych")
library(psych)

# EXPLORATORY DATA ANALYSIS
col.1 <- c(1,1,1,1,2,2,2,2,2,2,3,3,3,3,4,4,5,5,7)
col.2 <- c(1,1,2,2,3,3,3,4,4,4,4,4,5,5,5,6,6,7,7)
col.3 <- c(1,2,3,3,4,4,4,5,5,5,5,6,6,6,6,6,6,7,7)
df <- data.frame(col.1,col.2,col.3)
rm(col.1,col.2,col.3)

# summary() - provides relevant data on mean and median
summary(df)

# ----------------------------------------------------------------------------
# Skewness - checks if data is oriented to one side more than the other
pl_1 <- ggplot(df,aes(x=col.1))
pl_1 + geom_histogram(binwidth = 1,colour="white",fill="red4") +
  theme_light() +
  labs(title="Positive/Right Skew") # Mean > Median (outliers to the right)

pl_2 <- ggplot(df,aes(x=col.2))
pl_2 + geom_histogram(binwidth = 1,colour="white",fill="red4") +
  theme_light() +
  labs(title="Zero Skew") # Mean = Median (symmetrical)

pl_3 <- ggplot(df,aes(x=col.3))
pl_3 + geom_histogram(binwidth = 1,colour="white",fill="red4") +
  theme_light() +
  labs(title="Negative/Left Skew") # Mean < Median (outliers to the left)

# ----------------------------------------------------------------------------
# EXERCISE
setwd(paste("C:\\Users\\Daniel.Inacio\\Desktop",
            "\\R Programming for Statistics and Data Science",
            "\\4. Exploratory Data Analysis",
            sep=""))
skew_1 <- read.csv("skew_1.csv",
                   stringsAsFactors = FALSE)
skew_2 <- read.csv("skew_2.csv",
                   stringsAsFactors = FALSE)

# Identify the skews visually and numerically
summary(skew_1) # Mean>Median = Positive/Right Skew
summary(skew_2) # Mean,Median = Negative/Left Skew

describe(skew_1)
describe(skew_2)

# ----

sk1 <- ggplot(skew_1,aes(x=Dataset.1))
sk1 + geom_histogram(binwidth = 100,colour="white",fill="red4") +
  theme_light() +
  labs(title="Positive/Right Skew") # Mean > Median (outliers to the right)

sk2 <- ggplot(skew_2,aes(x=Dataset.2))
sk2 + geom_histogram(binwidth = 100,colour="white",fill="red4") +
  theme_light() +
  labs(title="Negative/Left Skew") # Mean < Median (outliers to the left)

# ----------------------------------------------------------------------------
# Variance - dispersion around mean value. CAN BE VERY LARGE!

# Standard Deviation - square root of variance. MORE MEANINGFUL!

# Coefficient of Variability / Relative Standard Deviation
# calc=(square root of variance/mean)

# ----------------------------------------------------------------------------
# Covariance and Correlation - used for more than 1 variable!!!
# Relation between structure cost and land value

homes <- read.csv("landdata-states.csv",
                   stringsAsFactors = FALSE)
homes <- as_tibble(homes)
homes.subset <- homes[homes$Date=="2001.25",]

homeplot <- ggplot(data=homes.subset,aes(x=log(Land.Value),y=Structure.Cost))
homeplot + geom_point() + theme_light() +
  labs(x="Land Value (Logarithmic)",
       y="Structure Cost",
       title="Relationship between land value and structure cost")
# Used log to avoid an incredibly high x-axis

# Corrleation Coefficient (-1 <= Correlation Coef. Value <= 1)
cor(homes$Land.Value,homes$Structure.Cost)
cor.test(homes$Land.Value,homes$Structure.Cost)

# Perfect positive correlation of 1
# One variable increase by 100 > Other variable increases by 100
# One variable depends solely on the other, and no other factors

# ----------------------------------------------------------------------------
# EXERCISE
customer <- read.csv("practical_customer.csv",
                   stringsAsFactors = FALSE)
product <- read.csv("practical_product.csv",
                     stringsAsFactors = FALSE)

# Task 1: What are the types of data and the levels of measurement of the
# following variables: Cust ID, Mortgage, Year of sale.
summary(customer)
summary(product)

# Task 2: Create a histogram which represents the Price variable.
# Use the default binwidth values first and then set bins of length
# $100,000. Use the data on all apartments, no matter if sold or not.
price <- ggplot(data=product,aes(x=Price))
price + geom_histogram(binwidth=100000,colour="darkslategray",
                       fill="darkslategray4",alpha = 0.7) + 
  ggtitle("House Prices Frequency Distribution") + 
  labs(y="Number of Houses", 
       x="Price") + 
  theme_minimal() +
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE))
# this gets rid of the scientific notation on the x axis

# Task 3: Interpret the results.
describe(product$Price)

# Task 4: Create a scatter plot showing the relationship between Price
# and Area. Use the data on all apartments, no matter if sold or not.
# Interpret the results.
sc_price_area <- ggplot(data=product,aes(x=Area..ft..,y=Price))
sc_price_area + geom_point() + theme_light() +
  labs(x="Price in USD",
       y="Area in square feet",
       title="Relationship between Price and Area") +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE))
# Strong linear relationship

# Task 5: Calculate the mean, median, mode, skewness, and standard deviation
# of Price for all apartments, no matter if sold or not.
describe(product$Price)

# Function that returns the mode
mode <- function(x){ 
  ta <- table(x)
  tam <- max(ta)
  if (all(ta == tam))
    mod <- NA
  else
    if(is.numeric(x))
      mod <- as.numeric(names(ta)[ta == tam])
  else
    mod <- names(ta)[ta == tam]
  return(mod)
}
mode(product$Price)

# Task 6: Interpret the measures.
# Skew is to the right. Some houses are more expensive, as outliers.

# Task 7: Calculate the correlation between Price and Area.
cor(product$Price,product$Area..ft..)
cor.test(product$Price,product$Area..ft..)

# Is the result in line with the scatterplot?
# YES