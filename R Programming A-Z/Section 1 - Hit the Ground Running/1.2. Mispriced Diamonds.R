library(ggplot2)

mydata <- read.csv(file.choose())

ggplot(data=mydata[mydata$carat<2.5,],
       aes(x=carat,y=price, colour=clarity)) + 
  geom_point(alpha=0.1) + 
  geom_smooth()

qplot(data=mydata,carat,price,colour=clarity,facets=.~clarity)

#PACKAGE INSTALLATION
#https://support.rstudio.com/hc/en-us/articles/201057987-Quick-list-of-useful-R-packages
# To Load Data
install.packages("DBI")
install.packages("odbc")
install.packages("RMySQL")
install.packages("RPostgreSQL")
install.packages("RSQLite")
install.packages("XLConnect")
install.packages("xlsx")
install.packages("foreign")
install.packages("haven")

# To Manipulate Data
install.packages("tidyverse")
install.packages("dplyr")
install.packages("tidyr")
install.packages("stringr")
install.packages("lubridate")

# To Visualize Data
install.packages("ggplot2")
install.packages("ggvis")
install.packages("rgl")
install.packages("htmlwidgets")
install.packages("googleVis")

#To Model Data
install.packages("tidymodels")
install.packages("car")
install.packages("mgcv")
install.packages("lme4")
install.packages("nlme")
install.packages("randomForest")
install.packages("multcomp")
install.packages("vcd")
install.packages("glmnet")
install.packages("survival")
install.packages("caret")

#To Report Results
install.packages("shiny")
install.packages("R Markdown")
install.packages("xtable")

#For Spatial Data
install.packages("sp")
install.packages("maptools")
install.packages("maps")
install.packages("ggmap")

#For Time Series and Financial Data
install.packages("zoo")
install.packages("xts")
install.packages("quantmod")

#To write high performance R code
install.packages("Rcpp")
install.packages("data.table")
install.packages("parallel")

#To work with the Web
install.packages("XML")
install.packages("jsonlite")
install.packages("httr")