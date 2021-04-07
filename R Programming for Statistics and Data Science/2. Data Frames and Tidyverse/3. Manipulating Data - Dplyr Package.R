# Manipulating Data: Dplyr and Tidyr Packages
library(tidyverse)

# ----------------------------------------------------------------------------
# DPLYR PACKAGE

# Load Star Wars dataset (included with dplyr)
# TIBBLE DATASET!
star <- starwars
star

# Initial Analysis
str(star)
is.data.frame(star)

# filter(...) - filter your data
filter(star,species=="Droid")
# OR
star[(star$species=="Droid") & (!is.na(star$species)),]
#view(star[(star$species=="Droid") & (!is.na(star$species)),])

filter(star,species=="Droid",homeworld=="Tatooine")

# select(...) - keep the columns you want
select(star,name,birth_year,homeworld,species,starships)
select(star,name,homeworld:species)
select(star,ends_with("color"))
select(star,name,vehicles,starships,everything())

# mutate(...) - adds a new variable and preserves the rest
star <- mutate(star,bmi=mass/((height/100)^2))
select(star,name,bmi)
# OR
star$bmi <- star$mass/((star$height/100)^2)
#star$bmi
#select(star,name,bmi)

# transmute(...) - adds a new variable and drops all others

# arrange(...) - reorders columns
arrange(star,desc(mass))

# summarize(...) - returns one single result
summarize(star,avg.height=mean(height,na.rm=TRUE))

# group_by(...) - splits data into groups
# Average height for EACH Species
star.species <- group_by(star,species)
star.species
summarize(star.species,avg.height=mean(height,na.rm=TRUE))

# sample(...)
sample(star,10) # get 10 random entries
sample_frac(star,0.1) # get 10% of my dataset

# Pipe Operator
# A way to avoid having multiple datasets as "save points"

# If I wanted the average mass and total count of each species
star.species <- group_by(star,species)
star.smr <- summarize(star.species,count = n(), avg.mass=mean(mass,na.rm=TRUE))
filter(star.smr,count>1)

# Using the Pipe Operator (you could nest but reading it would be too much!)
star %>%
  group_by(species) %>%
  summarize(count = n(), mass=mean(mass,na.rm=TRUE)) %>%
  filter(count>1)

# ------------------------------------------------------------------------------
# Exercise with the employees dataset

# Load dataset
getwd()
setwd(paste("C:\\Users\\Daniel.Inacio\\Desktop",
            "\\R Programming for Statistics and Data Science",
            "\\2. Data Frames and Tidyverse",
            sep=""))
employee.data <- read.csv("employee_data_exported.csv",
                          stringsAsFactors = FALSE)

# Convert to tibble
tibble(employee.data)
str(employee.data)

# Change relevant data to factors
employee.data$Gender <- factor(employee.data$Gender)
employee.data$Job.Title <- factor(employee.data$Job.Title)
str(employee.data)

# Check for missing data
summary(employee.data)
employee.data[!complete.cases(employee.data),] # 0 lines completely empty
any(is.na(employee.data)) # FALSE

# A: Who earns more than 70000? Organise it by gender and last name
# Make the first three columns the names and gender

# Specify the first 3 columns you want to see
employee.data <- select(employee.data,
                        First.Name,Last.Name,Gender, # OR ends_with("name")
                        everything())

# Get a dataframe with only the high earners' employee numbers
HighSalary <- employee.data[employee.data$Salary > 70000,]
# OR filter(employee.data$Salary > 70000)

# Arrange by gender
HighSalary <- arrange(HighSalary,desc(Gender))
HighSalary <- arrange(HighSalary,Last.Name)

# Get only the high earners' employee numbers
HighSalaryEMP <- HighSalary[,"Employee.Number", drop=FALSE]

# B: How much does each Job Title earn on average yearly by gender?
# Add a column for monthly average
HighSalary.Avg <- group_by(HighSalary,Job.Title,Gender)
HighSalary.Avg <- summarize(HighSalary.Avg,avg.salary=mean(Salary,na.rm=TRUE))

# Add the new column to your dataset
employee.data.new <- mutate(HighSalary.Avg,
                            AvgMonthly=avg.salary/12)
?mutate
employee.data.new <- arrange(employee.data.new,
                             desc(Gender),desc(AvgMonthly))