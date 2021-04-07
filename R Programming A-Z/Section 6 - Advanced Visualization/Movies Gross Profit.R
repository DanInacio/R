# Homework: Movie Domestic % Gross
library(ggplot2)

# Load Data
getwd()
setwd("C:\\Users\\Daniel.Inacio\\Desktop\\R Programming A-Z\\Section 6 - Advanced Visualization")
movieHW <- read.csv("Section6-Homework-Data.csv",stringsAsFactors = TRUE)

# Renaming specific columns
# names(movieHW)[names(movieHW) == "Day.of.Week"] <- "WeekDay"
colnames(movieHW) <- c("WeekDay","Director","Genre","MovieTitle","ReleaseDate",
                      "Studio","AdjGross","Budget","Gross","IMDBRating",
                      "MovieLensRating","Overseas","Overseas%",
                      "Profit","ProfitPer100","Runtime","US","GrossUSPer100")

# Initial Analysis
head(movieHW)
str(movieHW)
summary(movieHW)

# 1st Chart
chart <- ggplot(data=movieHW,mapping=aes(x=Genre,y=GrossUSPer100,
                                         colour=Studio))
chart + geom_boxplot()

# A first chart revealed there are too many studios and genres for this plot.
# The business chose to limit both.

# Filtering the dataframe
filteredMovieHW <- movieHW[movieHW$Studio == "Buena Vista Studios" |
                             movieHW$Studio == "Fox" |
                             movieHW$Studio == "Paramount Pictures" |
                             movieHW$Studio == "Sony" |
                             movieHW$Studio == "Universal" |
                             movieHW$Studio == "WB",]

relevantMovies <- filteredMovieHW[filteredMovieHW$Genre == "action" |
                                    filteredMovieHW$Genre == "adventure" |
                                    filteredMovieHW$Genre == "animation" |
                                    filteredMovieHW$Genre == "comedy" |
                                    filteredMovieHW$Genre == "drama",]

# You could have also applied both filters at the same time
# relevantMovies <- movieHW[filter1 & filter2,]

# Redo the chart
windowsFonts("EY Gothic" = windowsFont("EY Gothic"))

# The basis of the chart
newChart <- ggplot(data=relevantMovies,mapping=aes(x=Genre,y=GrossUSPer100))
newChart + geom_boxplot()

# And now the chart improvements
# Notice colour and size changes are only on the jitter, not on the boxplots!
# Splitting the box plot by studio through colouring would destroy the chart
# Notice the "outlier.colour=NA" to remove outliers
# Notice the finalChart as a way to "Save" our work
newChart2 <- newChart +
  geom_jitter(aes(colour=Studio,size=Budget)) +
  geom_boxplot(alpha=0.7,outlier.colour = NA)

newChart2

# And finally the visual changes
# Labelling
finalChart <- newChart2 +
  xlab("Genre") +
  ylab("Gross% US") +
  ggtitle("Domestic Gross % by Genre")

finalChart

# Theme
finalChart +
  theme(plot.title = element_text(size=40,
                                  hjust = 0.5),
        axis.title.x = element_text(colour="Blue",
                                    size=30),
        axis.title.y = element_text(colour="Blue",
                                    size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20),
        
        legend.title = element_text(size=20),
        legend.text = element_text(size=20),
        
        text = element_text(family="EY Gothic"))

# Final Touch: Change legend title!
finalChart$labels$size <- "Budget M$"

# Interesting Insight
ggplot(movieHW,aes(x=WeekDay)) + geom_bar()
# No movies are released on a Monday