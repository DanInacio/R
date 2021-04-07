# VISUALIZING DATA
library(ggplot2)
library(ggthemes)
library(wesanderson)
#install.packages("ggthemes")
#install.packages("wesanderson")

# Load Data
getwd()
setwd(paste("C:\\Users\\Daniel.Inacio\\Desktop",
            "\\R Programming for Statistics and Data Science",
            "\\3. Visualizing Data",
            sep=""))
hdi <- read.csv("hdi-cpi.csv",
                stringsAsFactors = FALSE)

# ----------------------------------------------------------------------------
# Human Development Index vs Corruption Perception Index
# Graph Intro
sc <- ggplot(data=hdi,aes(x=CPI.2015,y=HDI.2015)) # DATA, AESTHETICS

sc + geom_point(aes(colour=Region),size=3) +      # GEOMETRY
  #facet_grid(Region~.) +                         # FACETS
  stat_smooth() +                                 # STATISTICS
  #coord_cartesian(xlim=c(0.75,1)) +              # COORDINATES
  theme_minimal()                                 # THEMES

# Did you notice "that" country?
# hdi[hdi$CPI.2015 < 0.2 & hdi$HDI.2015 > 0.85,]

# ----------------------------------------------------------------------------
# Histogram (numerical, continuous data -> view frequency of observations)
titanic <- read.csv("titanic.csv",
                    stringsAsFactors = FALSE)

# Initial Analysis
str(titanic)
titanic$Survived <- as.factor(titanic$Survived)
titanic$Pclass <- as.factor(titanic$Pclass)
titanic$Sex <- as.factor(titanic$Sex)
titanic$Embarked <- as.factor(titanic$Embarked)
str(titanic)

# GGPLOT
hist <- ggplot(data=titanic,aes(x=Age))
hist + geom_histogram(binwidth=5, # 0-5,5-10,10-15 years old and so on...
                      fill="darkslategray4",colour="darkslategray",
                      alpha=0.5) +
  ggtitle("Age Distribution aboard the Titanic") +
  labs(y="Number of Passengers",x="Age") +
  theme_minimal()

# Histogram Exercise
setwd(paste("C:\\Users\\Daniel.Inacio\\Desktop",
            "\\R Programming for Statistics and Data Science",
            "\\3. Visualizing Data\\Exercise1_Histogram",
            sep=""))
employeeData <- read.csv("employee-data.csv",
                         stringsAsFactors = FALSE)

# GGPLOT
employeeData <- employeeData[employeeData$Salary>45000,]
histEmp <- ggplot(data=employeeData,aes(x=Salary))
histEmp + geom_histogram(binwidth=5000,
                         fill="darkslategray4",colour="darkslategray",
                         alpha=0.7) +
  ggtitle("Employee Salary") +
  labs(y="Number of Employees in the Salary Bracket",
       x="Salary") +
  theme_solarized_2(light=TRUE,
                    base_size=15,
                    base_family="serif")

# ----------------------------------------------------------------------------
# Bar Chart (x=Categories to Compare,y=Value to measure (count,%,etc.))
setwd(paste("C:\\Users\\Daniel.Inacio\\Desktop",
            "\\R Programming for Statistics and Data Science",
            "\\3. Visualizing Data",
            sep=""))
titanic <- read.csv("titanic.csv",
                    stringsAsFactors = FALSE)

bar <- ggplot(data=titanic,aes(x=Survived))
bar + geom_bar(aes(fill=Sex),colour="black") +
  labs(y="Passenger Count", title="Survival Rate on the Titanic") + 
  theme_light()

# ATTENTION: You need to confirm your "fill" data is a factor!!!
bar2 <- ggplot(data=titanic,aes(x=Sex))
bar2 + geom_bar(aes(fill=Survived),colour="black") +
  labs(y="Passenger Count",x="Gender",title="Survival Rate by Gender") + 
  theme_light() +
  facet_grid(Sex~Pclass)

# Let's add survival rate to our previous histogram
# Theme minimal will NOT allow FILL COLOURING!!!
hist <- ggplot(data=titanic,aes(x=Age,fill=Survived))
hist + geom_histogram(binwidth=5,colour="white") +
  ggtitle("Age Distribution aboard the Titanic") +
  labs(y="Number of Passengers",x="Age") +
  theme_light()

# Bar Plot Exercise
barEmp <- ggplot(data=employeeData,aes(x=Job.Title))
barEmp + geom_bar(aes(fill=Gender),colour="Black") +
  labs(y="Employee Count", x="Job Position",
       title="Job Positions by Gender") + 
  theme_fivethirtyeight()
# theme_fivethirtyeight() does not allow us to name the x- and y-axis
# scale_fill_manual() allows us to change the fill colours

# ----------------------------------------------------------------------------
# Box and Whiskers (represent numerical data in quartiles)
box <- ggplot(data=titanic,aes(x=Survived,y=Age))
box +
  geom_jitter(aes(colour=Sex)) +
  geom_boxplot(alpha=0.7,outlier.colour = "red",
               outlier.shape = 4,outlier.size = 5) +
  labs(y="Age", x="Survived",title="Survival Rate on the Titanic") +
  theme_light()

# You can have it horizontal!!!
box <- ggplot(data=titanic,aes(x=Survived,y=Age))
box +
  geom_jitter(aes(colour=Sex)) +
  geom_boxplot(alpha=0.7,outlier.colour = "red",
               outlier.shape = 4,outlier.size = 5) +
  labs(y="Age", x="Survived",title="Survival Rate on the Titanic") +
  theme_light() + coord_flip()

# Box Plot Exercise
boxEmp <- ggplot(data=employeeData,aes(x=Job.Title,y=Salary))
boxEmp +
  geom_jitter(aes(colour=Gender)) +
  geom_boxplot(alpha=0.7,outlier.colour = "red",
               outlier.shape = 4,outlier.size = 3) +
  ggtitle("Salary Distribution",subtitle="based on Position and Gender") +
  labs(y="Salary", x="Job Title") +
  theme_economist_white() +
  theme(
    legend.position = "right",
    axis.text.x = element_text(angle = 90, hjust = 1), # Flips axis text
  ) +
  coord_flip() +
  scale_color_brewer(palette="Set1")

# ----------------------------------------------------------------------------
# Scatterplot
scp <- ggplot(data=hdi,aes(x=CPI.2015,y=HDI.2015))
scp + geom_point(aes(colour=Region),shape=21,fill="white",size=3,stroke=2) +
  theme_light() +
  labs(x="Corruption Perception Index, 2015",
       y="Human Development Index, 2015",
       title="Corruption and Human Development") +
  geom_smooth(fill=NA) +
  geom_density2d() # Good for over-populated charts