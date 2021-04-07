# Linear Regression Analysis
# Make predictions for the population

# Remember Weight and Bias in ML

# Correlation is about mutual relation between 2 variables
# Regression is about how one variable affects another (x and y)

library(tidyverse)
library(psych)
library(scales) # Create a custom format when plotting the data

# Load Data
setwd(paste("C:\\Users\\Daniel.Inacio\\Desktop",
            "\\R Programming for Statistics and Data Science",
            "\\6. Linear Regression Analysis",
            sep=""))
college <- read.csv("regression_example.csv",stringsAsFactors = FALSE)

# Initial Analysis
str(college)
summary(college)
describe(college)

# Linear Model
# y_hat = b0 + b1x1 + epsilon
?lm
linear_model <- lm(formula=GPA ~ SAT,data=college)
linear_model
summary(linear_model)

# View your Linear Model
ggplot(data=college,aes(x=SAT,y=GPA)) +
  geom_point() +
  theme_light() +
  labs(x="SAT Scores",
       y="GPA upon Graduation",
       title="SAT and GPA") +
  geom_smooth(method="lm",se=FALSE) # To print your linear model
# se is your confidence interval

# Interpret the regression results
linear_model
summary(linear_model) # Estimated Value, Error, t_table value and p_value

# b0=0.275 (Intercept Estimate)
# b1=0.0017
# GPA=0.275 + 0.0017*SAT

# H0: b0  = 0 (crosses y-axis at 0)
# H1: b0 != 0
# It is asking if b0 is a useful value

# A p_value < 0.05 would mean it is significant
# b1 is VERY significant
# b0 is NOT

# ----------------------------------------------------------------------------
# EXERCISE

# Load Data
housing <- read.csv("real_estate_price_size_year_view.csv",
                    stringsAsFactors = FALSE)
housing <- as_tibble(housing)

# Initial Analysis
str(housing)
summary(housing)

housing$view <- as.factor(housing$view) # Factor

# Linear Models
LM_Price_Size <- lm(formula=price ~ size,data=housing)
LM_Price_Year <- lm(formula=price ~ year,data=housing)
LM_Price_View <- lm(formula=price ~ view,data=housing)

summary(LM_Price_Size) # y-hat = 101912.6 + 223.2*x1 
summary(LM_Price_Year) # NOT RELEVANT (look at the error!)
summary(LM_Price_View) # NOT RELEVANT (look at the error!)

# Plot the Models
point <- format_format(big.mark = " ", decimal.mark = ",", scientific = FALSE)
# this helps us get rid of the scientific notation in the graph
ggplot(data=housing,aes(x=size,y=price)) +
  geom_point() +
  theme_light() +
  labs(x="Size",
       y="Price",
       title="Size vs. Price") +
  scale_x_continuous(labels = point) + # this is where we tell ggplot2 to use
  scale_y_continuous(labels = point) + # the format we set up above (point)
  geom_smooth(method="lm",se=FALSE)

# How many observations was the regression run on?

# 100. This is evident from the degrees of freedom (residual)
# degrees of freedom (residual) is calculated based on the sample size (n)
# minus the number of parameters (k) being estimated minus 1
# degrees of freedom (residual) = n - k - 1 
# 98 = n - 1 - 1 
# n = 100

# What is the R-squared of this regression? What does it tell you?

# Adjusted R-squared: 0.7421
# The adjusted R-squared increases only if the new term improves the model
# The value tells us that this regression model (~75%)

# ----------------------------------------------------------------------------
# SST,SSR,SSE

# SST: Sum of Squares Total      (diff. between y and y_hat)
# SSR: Sum of Squares Regression (diff. between mean(y) and y_hat)
# SSE: Sum of Squares Error      (diff. between SST and SSR)
#   a.k.a, RSS: Residual Sum of Squares

# SST = SSR + SSE
# total variability = explained variability + unexplained variability

# ----------------------------------------------------------------------------
# R-Squared = SSR/SST
# Shows your model's Accuracy!