#5.6. Building Data Frames
#Load the Country vectors supplied

# Create a dataframe with vectors
MyDF <- data.frame(Countries_2012_Dataset,
                   Codes_2012_Dataset,
                   Regions_2012_Dataset)
head(MyDF)

# Change column names
#colnames(MyDF) <- c("Country","Code","Region")
#head(MyDF)
rm(MyDF)

# You can simply create the dataframe with the new names!
MyDF <- data.frame(Country=Countries_2012_Dataset,
                   Code=Codes_2012_Dataset,
                   Region=Regions_2012_Dataset)
head(MyDF)
summary(MyDF)

#---------------------------------------------
# Merging Data Frames
# We want part of the MyDF into the stats data frame

head(stats)
head(MyDF)

# Add the Region column into stats data frame, based on a matching column
?merge()

mergedDF <- merge(stats,MyDF,
                  by.x="Country.Code",
                  by.y="Code")
mergedDF$Country <- NULL

rm(mergedDF)

mergedDF <- merge(stats,MyDF,
                  by.x=c("Country.Code","Country.Name"),
                  by.y=c("Code","Country"))