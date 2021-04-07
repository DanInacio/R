#World Trends
library(ggplot2)

getwd()
setwd("C:\\Users\\Daniel.Inacio\\Desktop\\R Programming A-Z\\Section 5 - Data Frames")
worldFertility <- read.csv("P2-Section5-Homework-Data.csv",stringsAsFactors = TRUE)
#EXECUTE THE VECTORS FILE!

#Create DFs with the vectors
DataFrame1960 <- data.frame(Code=Country_Code,
                            LE1960=Life_Expectancy_At_Birth_1960)

DataFrame2013 <- data.frame(Code=Country_Code,
                            LE2013=Life_Expectancy_At_Birth_2013)

#Split the worldFertility data frame into 2, based on year
WF1960 <- worldFertility[worldFertility$Year == 1960,]
WF2013 <- worldFertility[worldFertility$Year == 2013,]

#Merge the dataframes from CSV with the vectors
Full1960DF <- merge(WF1960,DataFrame1960,
                    by.x="Country.Code",
                    by.y="Code")
Full1960DF$Year <- NULL

Full2013DF <- merge(WF2013,DataFrame2013,
                    by.x="Country.Code",
                    by.y="Code")
Full2013DF$Year <- NULL

rm(DataFrame1960,DataFrame2013,WF1960,WF2013,worldFertility,
   Country_Code,Life_Expectancy_At_Birth_1960,Life_Expectancy_At_Birth_2013)

#First Analysis
head(Full1960DF)
str(Full1960DF)

head(Full2013DF)
str(Full2013DF)

# Visualize the Data
qplot(data=Full1960DF,x=Fertility.Rate,y=LE1960,size=I(5), colour=Region,
      shape=I(19),alpha=I(0.5),main="Fertility Rate vs. Life Expectancy")

qplot(data=Full2013DF,x=Fertility.Rate,y=LE2013,size=I(5), colour=Region,
      shape=I(19),alpha=I(0.5),main="Fertility Rate vs. Life Expectancy")
