#5.1. Importing Data
#?read.csv

#Method 1: Manual Selection of File
stats <- read.csv(file.choose())

#Method 2: Set Working Directory and Read Data Automatically
getwd()
setwd("C:\\Users\\Daniel.Inacio\\Desktop\\R Programming A-Z
      \\Section 5 - Data Frames")
stats <- read.csv("P2-Demographic-Data.csv",stringsAsFactors = TRUE)
#OR
#stats <- read.csv("C:\\Users\\Daniel.Inacio\\Desktop
#                   \\R Programming A-Z\\Section 5 - Data Frames
#                   \\P2-Demographic-Data.csv")

# -------------------------------------------------------------

# 195 rows, 5 columns (or read the environment on the right side!)
nrow(stats)
ncol(stats)

# A short sample of data
head(stats) # head(stats,n=10)
tail(stats)

# Structure of the data frame
str(stats)

# Summary of the data range
summary(stats)