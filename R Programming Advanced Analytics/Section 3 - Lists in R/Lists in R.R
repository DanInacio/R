# Lists in R

# Deliverables - A list with the following components
# Character: Machine Name
# Vector: Min,Mean,Max Utilization for the month, excluding unknown hours
# Logical: Has utilization ever fallen below 90% (TRUE/FALSE)
# Vector: All hours where utilization is unknown
# Dataframe: For RL1 Machine
# Plot: For all machines

# Vectors only allow 1 type of data
# Lists can store all types of data
# (vector, matrix, dataframe, plot, single value, string, numeric, etc.)

library(ggplot2)

# ----------------------------------------------------------------------------
# Load Data
getwd()
setwd("C:\\Users\\Daniel.Inacio\\Desktop\\R Programming Advanced Analytics\\Section 3 - Lists in R")
utilDF <- read.csv("P3-Machine-Utilization.csv",
                   stringsAsFactors = TRUE,
                   na.strings = c(""))

# ----------------------------------------------------------------------------
# Initial Analysis
head(utilDF,12)
tail(utilDF)
str(utilDF)
summary(utilDF)
# Notice equal number of entries for the machines
# Makes sense, since there are hourly records for all machines
# Notice the amount of NA's

# ----------------------------------------------------------------------------
# Derive utilization column
utilDF$Utilization <- 1 - utilDF$Percent.Idle
head(utilDF,12)

# ----------------------------------------------------------------------------
# Handling Date/Time in R
# Check if European or American date format
tail(utilDF,12) # European

# There is a universal format! Let's convert:
?POSIXct # Number of seconds since 1970
?as.POSIXct

as.POSIXct(utilDF$Timestamp, format="%d/%m/%Y %H:%M")
utilDF$POSIXTime <- as.POSIXct(utilDF$Timestamp, format="%d/%m/%Y %H:%M")
head(utilDF,12)
summary(utilDF)
str(utilDF)

# TIP: Rearrange columns in a Data Frame
utilDF$Timestamp <- NULL # Don't need it anymore

utilDF <- utilDF[,c(4,1,2,3)]

# ----------------------------------------------------------------------------
# What is a List?
summary(utilDF)

# We only need RL1 Machine
RL1DF <- utilDF[utilDF$Machine=="RL1",]
summary(RL1DF)
# The other machines still show up because we need to re-run the factor!

RL1DF$Machine <- factor(RL1DF$Machine)
summary(RL1DF)

# ----------------------------------------------------------------------------
# Build the list components
# Character: Machine Name (DONE)
# Vector: Min,Mean,Max Utilization for the month, excluding unknown hours
# Logical: Has utilization ever fallen below 90% (TRUE/FALSE)

listRL1_stats <- c(min(RL1DF$Utilization),
                   mean(RL1DF$Utilization),
                   max(RL1DF$Utilization))

# Remove the NA's
listRL1_stats <- c(min(RL1DF$Utilization,na.rm = TRUE),
                   mean(RL1DF$Utilization,na.rm = TRUE),
                   max(RL1DF$Utilization,na.rm = TRUE))
listRL1_stats

# Logical Vector (filter returns TRUE and NA! Use which())
RL1DF$Utilization < 0.9
which(RL1DF$Utilization < 0.9)
listRL1_below90 <- which(RL1DF$Utilization < 0.9)
listRL1_below90 # int, not yet logical

# Convert to logical
listRL1_below90 <- listRL1_below90 > 0
# OR
listRL1_below90 <- as.logical(listRL1_below90)

# We only want one single logical value, i.e. has it ever happened even once?
listRL1_below90_flag <- length(listRL1_below90) > 0

# Create the list
RL1_List <- list("RL1",listRL1_stats,listRL1_below90_flag)
RL1_List

# ----------------------------------------------------------------------------
# Naming components of a list
names(RL1_List) # NO NAMES! Using only the default indexation 1,2,3

names(RL1_List) <- c("Machine","Stats","LowThreshold")
RL1_List

# Another way, like with dataframes, name as you create:
rm(RL1_List)
RL1_List <- list(Machine="RL1",
                 Stats=listRL1_stats,
                 LowThreshold=listRL1_below90_flag)
RL1_List

# ----------------------------------------------------------------------------
# 3 Methods for Extracting components lists [] vs [[]] vs $
RL1_List

# 1st Method: [] - will always return a list
RL1_List[1]
RL1_List["Machine"]
RL1_List[2]
RL1_List["Stats"]
typeof(RL1_List[2])

# 2nd Method: [[]] - will always return the object within the component
RL1_List[[1]]
RL1_List[["Machine"]]
RL1_List[[2]]
RL1_List[["Stats"]]
typeof(RL1_List[[2]])

# 3rd Method: $ - same as [[]] but cleaner
RL1_List$Machine
RL1_List$Stats
typeof(RL1_List$Stats)

# How would you access the max utilization of the vector?
RL1_List$Stats[3]

# ----------------------------------------------------------------------------
# Adding and deleting components
# Vector: All hours where utilization is unknown
# Dataframe: For RL1 Machine
RL1_List

# One way
RL1_List[4] <- "New Information"
# Another way (Vector: All hours where utilization is unknown)
RL1DF
RL1DF[is.na(RL1DF$Utilization),] # All rows
RL1DF[is.na(RL1DF$Utilization),"POSIXTime"] # Just the hours

RL1_List$UnknownHours <- RL1DF[is.na(RL1DF$Utilization),"POSIXTime"]

# Deleting a component
RL1_List[4] <- NULL

# Notice, unlike a dataframe, indices have shifted!
RL1_List

# Add another component (Dataframe: For RL1 Machine)
RL1_List$Data <- RL1DF
summary(RL1_List)
str(RL1_List)

# ----------------------------------------------------------------------------
# Subsetting a list

#Quick question:  How would you access the first unknown date?
RL1_List$UnknownHours[1]

# To subset a list, and not values, use []
RL1_List[1]
RL1_List[1:2]
RL1_List[c(1,4)]
RL1_List[c("Machine","Stats")]
sublist_RL1 <- RL1_List[c("Machine","Stats")]
sublist_RL1$Stats[1]

# You cannot subset with [[]] or $, only get 1 object at a time!

# ----------------------------------------------------------------------------
# Creating a Time Series Plot
# Plot: For all machines

p <- ggplot(data=utilDF)
MyPlot <- p + geom_line(aes(x=POSIXTime,y=Utilization,
                        colour=Machine),size=1.2) +
  geom_hline(yintercept=0.9, linetype="dotted", color = "Gray", size=1.2) +
  facet_grid(Machine~.)
MyPlot

RL1_List$Plot <- MyPlot

RL1_List
summary(RL1_List)
str(RL1_List)