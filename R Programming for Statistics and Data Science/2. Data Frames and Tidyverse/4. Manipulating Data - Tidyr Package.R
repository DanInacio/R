library(tidyverse)

# ----------------------------------------------------------------------------
# TIDYR PACKAGE

# Load dataset
getwd()
setwd(paste("C:\\Users\\Daniel.Inacio\\Desktop",
            "\\R Programming for Statistics and Data Science",
            "\\2. Data Frames and Tidyverse\\tidyr",
            sep=""))
billboard <- read.csv("billboard.csv",
                      stringsAsFactors = FALSE)

# As tibble
billboard <- as_tibble(billboard)
is_tibble(billboard)
billboard

# gather(...) - reorganizes data that has values as column names
# VALUES AS COLUMNS is messy data
# gather(...) is the solution
billboard.gathered <- gather(billboard,"x1st.week":"x76th.week",
                             key="Week",value="Rank",na.rm=TRUE)
billboard.gathered <- arrange(billboard.gathered,artist.inverted)
# Key: New variable which will hold the values masked as column names
# Value: New variable which will hold the previous cell values

# separate(...) - splits 1 column in multiple
# MUTIPLE VARIABLES IN THE SAME COLUMN is messy data
# separate(...) is the solution
tb <- read.csv("tb.csv",
               stringsAsFactors = FALSE)
tb <- as_tibble(tb)

# Since values are as columns, first apply gather(...)
tb.gathered <- gather(tb,"m.014":"f.65",
                       key="column",value="cases",na.rm=TRUE)
tb.gathered <- arrange(tb.separated,country)

# Now separate the different values of the columns
tb.separated <- separate(tb.gathered,col="column",
                         into=c("Gender","Age")) # Dot is default value

# Hyphenate the age range
tb.separated$Age <- str_replace_all(tb.separated$Age,"0","0-")
tb.separated$Age <- str_replace_all(tb.separated$Age,"15","15-")
tb.separated$Age <- str_replace_all(tb.separated$Age,"25","25-")
tb.separated$Age <- str_replace_all(tb.separated$Age,"35","35-")
tb.separated$Age <- str_replace_all(tb.separated$Age,"45","45-")
tb.separated$Age <- str_replace_all(tb.separated$Age,"55","55-")
tb.separated$Age <- str_replace_all(tb.separated$Age,"65","65-100")

# unite(...) - joins columns into one
# ONE VARIABLE IN TWO COLUMNS is messy data
# unite(...) is the solution

# Let's put the age gap into two columns, low and high
tb.separated <- separate(tb.separated,col="Age",
                         into=c("AgeLow","AgeHigh"),sep="-")

# Let's put the age gap back into one column
tb.united <- unite(tb.separated,
                   col=c("AgeUnited",c("AgeLow","AgeHigh")),sep="-")
# WARNING: You may need an older version of R to run this command!

# Alternate version
tb.united <- tb.separated
tb.united$AgeUnited <- paste(tb.separated$AgeLow,"-",tb.separated$AgeHigh)
tb.united$AgeLow <- NULL
tb.united$AgeHigh <- NULL
tb.united <- select(tb.united,country,year,Gender,AgeUnited,everything())

# spread(...) - 
# COLUMN NAMES IN THE VALUES is messy data
# spread(...) is the solution
weather <- read.csv("weather.csv",
                    stringsAsFactors = FALSE)
weather <- as_tibble(weather)
weather
# Notice that, because of the messy data, days are repeated!
?spread
weather.spread <- spread(weather,key="element",value="value")

# ----------------------------------------------------------------------------
# EXERCISE 1
# Load dataset
getwd()
setwd(paste("C:\\Users\\Daniel.Inacio\\Desktop",
            "\\R Programming for Statistics and Data Science",
            "\\2. Data Frames and Tidyverse\\tidyr\\EXERCISE",
            sep=""))
weather <- read.csv("weather_untidy.csv",
                      stringsAsFactors = FALSE)

# As tibble
weather <- as_tibble(weather)
is_tibble(weather)
weather

# Gather (d1 to d31 are one single variable)
weather.gathered <- gather(weather,"d1":"d31",
                           key="Day",value="value",na.rm=TRUE)
weather.gathered$Day <- parse_number(weather.gathered$Day) # removed 'd'

# Spread (TMAX and TMIN are column names, not values)
# Key is the data we are changing, Value is what we are preserving
weather.spread <- spread(weather.gathered,key="element",value="value")

# ----------------------------------------------------------------------------
# EXERCISE 2
getwd()
setwd(paste("C:\\Users\\Daniel.Inacio\\Desktop",
            "\\R Programming for Statistics and Data Science",
            "\\2. Data Frames and Tidyverse\\tidyr\\EXERCISE",
            sep=""))
tb <- read.csv("tb_untidy.csv",
               stringsAsFactors = FALSE)
tb <- as.tibble(tb)

# Initial Analysis
str(tb)
summary(tb) # Notice all the empty columns

tb$mu <- NULL
tb$fu <- NULL
tb$f04 <- NULL
tb$f514 <- NULL
tb$m04 <- NULL
tb$m514 <- NULL

# Gather (male and female are columns and they should be values)
# Key is the new variable for the column
# Value is the new variable for the values into that column
tb.gathered <- gather(tb,"m014":"f65",
                      key="column",value="cases")

# Separate (gender and age are in the same column)
#tb.separated <- separate(tb.gathered,col="column",
#                         into=c("Gender","Age"),sep="")

# We need a separator symbol! Use mutate so it won't drop the data frame
tb.separated <- mutate(tb.gathered,
                       column=str_replace(tb.gathered$column,"m","m."))
tb.separated <- mutate(tb.separated,
                       column=str_replace(tb.separated$column,"f","f."))

# Now separate
tb.tidy <- separate(tb.separated,col="column",
                    into=c("Gender","Age"))

# Hyphenate the age range
tb.tidy$Age <- str_replace_all(tb.tidy$Age,"0","0-")
tb.tidy$Age <- str_replace_all(tb.tidy$Age,"15","15-")
tb.tidy$Age <- str_replace_all(tb.tidy$Age,"25","25-")
tb.tidy$Age <- str_replace_all(tb.tidy$Age,"35","35-")
tb.tidy$Age <- str_replace_all(tb.tidy$Age,"45","45-")
tb.tidy$Age <- str_replace_all(tb.tidy$Age,"55","55-")
tb.tidy$Age <- str_replace_all(tb.tidy$Age,"65","65-100")

# Reorder as you please
tb.tidy <- arrange(tb.tidy,country)