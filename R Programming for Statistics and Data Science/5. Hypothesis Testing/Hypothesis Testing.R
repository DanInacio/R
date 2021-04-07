# Hypothesis Testing = Predicting population values based on sample data
# Normalizing your data into z-scores allows you to predict population values

# ---------------------------------------------------------------------------
# Standard Error
# - Standard Deviation is a measure of variability
# - Standard Error is the same, on a larger scale

# Getting several samples gets you several mean values
# The mean of sample means is the mean value of the population
# The sd of samples is the standard error of the population

# If small, our sample mean may be very close to the population mean
# If large, our sample mean may be very far from the population mean

# ---------------------------------------------------------------------------
# Confidence Intervals
# - A range of values where the population mean is likely to fall
# - Best if the gap is small (95% confidence)
# - (a large interval allows the population mean to be practically anywhere)

# ---------------------------------------------------------------------------
# Hypothesis Testing
# H1 - Hypothesis that the statement is true (alternative hypothesis)
# H0 - Hypothesis that the statement is false (null hypothesis)

# ---------------------------------------------------------------------------
# TEST FOR THE MEAN - Population Variance Known
library(tidyverse)
library(psych)
#install.packages("pastecs")
library(pastecs)

# Load Data
getwd()
setwd(paste("C:\\Users\\Daniel.Inacio\\Desktop",
            "\\R Programming for Statistics and Data Science",
            "\\5. Hypothesis Testing",
            sep=""))
sal <- read.csv("ztest-a.csv",stringsAsFactors = FALSE)
# STANDARD DEVIATION KNOWN=15000 (publicly available)
# POPULATION MEAN KNOWN=113000 (publicly available)

# Initial Analysis
summary(sal) # Mean=100200; Median=101236

# Test for the Mean (is that value correct?)
# H0 - mean is 113000
# H1 - mean is NOT 113000

# We need to normalize our data into z-values!!!
z_test <- function(a,mu,sd){
  zeta = (mean(a)-mu) / (sd/sqrt(length(a)))
  return(zeta)
}

z_test(a=sal$salary,mu=113000,sd=15000) # Z=-4.674 AND 4.674, for 2-sided tests

# Now we compare this normalized value with the z-table
# The absolute value of the z-score should be higher
# than the absolute value of z (4.674 > z) OR (-4.674 < (-z))

# At alpha=0.05 and z=1.645 (because p=0.9505), z=1.6
# 4.674 > 1.6
# We reject the null hypothesis

# ----------------------------------------------------------------------------
# EXERCISE: Test the null hypothesis at 10% significance
# sample mean: $100,200
# population sd: $15,000
# standard error: $2,739
# sample size: 30
# z-score: -4.67
# H0: (Glassdoor data): $113,000

# Note: this should be a two-sided test

z_test(a=sal$salary,mu=113000,sd=15000)
# Z=4.67
# z=1.65 (from table)
# alpha=0.05 (0.025 for two-sided tests)

# 4.67 > 1.65 
# therefore, the null is rejected

# ----------------------------------------------------------------------------
# P-Value
# What is the lowest level of significance at which you can reject the NULL?

# ---------------------------------------------------------------------------
# TEST FOR THE MEAN - Population Variance Unknown
# Our company's open rate = 0.4 - Is the competitor higher?
# Significance of 0.05 is adequate (alpha=0.05)
rate <- read.csv("ttest-a.csv",stringsAsFactors = FALSE)
describe(rate)

# One-sided test
# H0: mean <= 0.4
# H1: mean > 0.4

my.t.test <- function(a,hmean){
  t = (mean(a) - hmean) / (sd(a)/sqrt(length(a)))
  return(t)
}

my.t.test(a=rate$Open.rate,hmean=0.4) # T=0.53
# In a t-table, df means degrees of freedom = sample size-1
# t=1.83
# In a T-score, we reject the null if table t is lower than obtained t (t<T)
# At this level of significance, we cannot say
# the competition is higher than 40%. WE CANNOT REJECT THE NULL

# ----------------------------------------------------------------------------
# EXERCISE: What if the open rate was EXACTLY 40%?
# Test for 5% and 1% significance
my.t.test(a=rate$Open.rate,hmean=0.4) # T=0.53,df=9

# At 5% (for 2-tailed tests) -> t=2.26
# At 1% (for 2-tailed tests) -> t=3.25)
# WE CANNOT REJECT THE NULL IN EITHER OPTION

# ----------------------------------------------------------------------------
# Comparing 2 means: dependent samples
magn <- read.csv("dependent-samples.csv",stringsAsFactors = FALSE)
describe(magn)
stat.desc(magn)

# We expect the mean of "after" to be higher than the "before" mean
# H0 -> "after" mean is smaller or equal than the "before" mean
# H1 -> "before" mean is smaller than "after" mean
# One-sided test

# T-Test for dependent samples (let's use R-Studio's function!!!)
?t.test
dep.t.test <- t.test(magn$Before,magn$After,
                     paired=TRUE, # dependent samples
                     alternative='less') # 1-tailed and H1 description
dep.t.test
# Probability to get 't' if H0 was true = 2.3%
# Low so we can safely reject the NULL, if alpha=0.05

# ----------------------------------------------------------------------------
# EXERCISE
weight <- read.csv("weight_data_exercise_kg.csv",stringsAsFactors = FALSE)
describe(weight)

# H1 - after mean is lower than before mean
# H0 - after mean is equal or higher than before mean
dep.t.test.weight <- t.test(weight$before,weight$after,
                            paired=TRUE,
                            alternative='greater') # 1-tailed
dep.t.test.weight
# Prob. is 3.8% (p-value=0.038)
# We can reject the NULL at alpha=0.05 (table t (1.83) < Our T (2.01))
# At 5% significance, we reject the null hypothesis. 
# Therefore, the program is successful.

# At alpha=0.1, table t = 1.383 < 2.01 -> WE REJECT THE NULL

# At alpha=0.01, table t = 2.82 > 2.01 -> WE ACCEPT THE NULL
# At 1% significance we accept the null hypothesis.
# The data shows that the program is not working.

# ----------------------------------------------------------------------------
# Comparing 2 means: Independent samples
# We believe the difference between engineering and management grades is 4%
# H1: mean(M)-mean(E) = 0.04
# H0: mean(M)-mean(E) != 0.04 (2-sided test)
grades <- read.csv("independent-samples.csv",stringsAsFactors = FALSE)
grades
describe(grades)

# T-Test for independent samples (let's use R-Studio's function!!!)
ind.t.test <- t.test(grades$Engineering,grades$Management,
                     paired=FALSE, # independent samples
                     mu=-4)
ind.t.test
# prob. is 1.6% (p-value is 0.016), abs(t)=2.43
# t_table, for alpha=0.05,df=100 is 1.66 < 2.43 -> WE REJECT THE NULL

# Note that t was negative. That means the difference is greater than -4 !!!