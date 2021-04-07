# cat("\014") to clear the console

# Section 7: Data Frames

# ----------------------------------------------------------------------------
# Creating a Data Frame
months <- c(53,19,34,41,84,140,109)
size <- c("medium","small","medium","large","small","small","large")
weight <- c(21,8,4,6,7,2,36)
breed <- c("dog","dog","cat","cat","dog","cat","dog")

pets <- data.frame("Months Old"=months,
                   "Size"=size,
                   "Breed"=breed,stringsAsFactors=TRUE)
row.names(pets) <- c("Flipper","Bromley","Nox","Orion",
                     "Dagger","Zizi","Carrie")
pets

str(pets)
rm(breed,months,size,weight)

# ----------------------------------------------------------------------------
# Tidyverse Package
# install.packages("tidyverse")
library(tidyverse)

# ggplot2 <- Data Visualization
# dplyr   <- Data Manipulation: filter(),arrange(),mutate()
# tidyr   <- Data Tidying
# readr   <- Importing Data into R (not just read.csv()). Faster!
# tibble  <- Lighter, more user-friendly version of data frames
# purrr   <- Better functional programming

# ----------------------------------------------------------------------------
# Data Import
getwd()
setwd(paste("C:\\Users\\Daniel.Inacio\\Desktop",
            "\\R Programming for Statistics and Data Science",
            "\\2. Data Frames and Tidyverse",
            sep=""))

#read.table(): Reads a file in table format and creates a data frame
pokemon <- read.table("pokRdex_comma.csv",
                      sep=',',
                      header=TRUE,
                      stringsAsFactors = FALSE) # False due to all the names
pokemon

#read.csv: sep=',' and header=TRUE
#read.csv(...,skip=n): Skips n lines in your file
#read.csv(...,nrows=n): Reads only n lines in your file
pokemon <- read.csv("pokRdex_comma.csv",
                    stringsAsFactors = FALSE)

# ----------------------------------------------------------------------------
# Data Export

# Separator=',' AND row.names = FALSE, otherwise it adds a new column
# write.csv(my.data,file="MyDataFrame.csv",row.names = FALSE)   

# Separator='TAB' AND row.names = FALSE, otherwise it adds a new column
# write.table(my.data,file="MyDataFrame.csv",row.names = FALSE)

# ----------------------------------------------------------------------------
# Importing/Exporting Exercise
employee.data <- read.csv("employee_data.csv",
                          skip = 23,
                          stringsAsFactors = FALSE)

colnames(employee.data) <- c("Employee Number","First Name","Last Name",
                             "Birth Date","Gender","Job Title",
                             "Salary","From Date","To Date")

write.csv(employee.data,
          file="employee_data_exported.csv",
          row.names=FALSE)

#Re/Import to make sure it is fine
new.employee.data <- read.csv("employee_data_exported.csv",
                              stringsAsFactors = FALSE)

# ----------------------------------------------------------------------------
# Initial Analysis of your Data Frame
nrow(pokemon)
ncol(pokemon)
colnames(pokemon)
rownames(pokemon)
str(pokemon)
summary(pokemon)

# ----------------------------------------------------------------------------
# Indexing and Slicing your Data Frame
head(pokemon)
tail(pokemon)
pokemon[6,]
pokemon[6,2]
pokemon[6,"pokemon"]
pokemon$base_experience[6]

# ----------------------------------------------------------------------------
# Extending a Data Frame in R (Use the pets data frame)
pets

# Adding a column
vaccinated <- c("Yes","Yes","No","Yes","No","No","Yes")
petsv <- cbind(pets,"Vaccinated"=vaccinated)
petsv

# Adding a row
milo <- data.frame(row.names="Milo", Months.Old=67, Size="small",
                   Breed="dog", Vaccinated="Yes")
petsvm <- rbind(petsv, milo)
petsvm