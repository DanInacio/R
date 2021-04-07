#6.1. Movie Data
library(ggplot2)

# Load Data
getwd()
setwd("C:\\Users\\Daniel.Inacio\\Desktop\\R Programming A-Z\\Section 6 - Advanced Visualization")
movies <- read.csv("P2-Movie-Ratings.csv",stringsAsFactors = TRUE)

head(movies)

# Renaming specific columns
colnames(movies) <- c("Film","Genre",
                      "CriticRating","AudienceRating",
                      "BudgetMillions","Year")
head(movies)
str(movies)
summary(movies)
is.data.frame(movies)

# Year is treated as number. We want it as a category (i.e.: Factor)

# Convert columns into factors
factor(movies$Year)
movies$Year <- factor(movies$Year)

# ----------------------------------------------------------------------------
# Aesthetics (i.e.: "Things we can see")
ggplot(data=movies,mapping=aes(x=CriticRating,y=AudienceRating,Genre))

# Add Geometry Layer
ggplot(data=movies,mapping=aes(x=CriticRating,y=AudienceRating,Genre)) +
  geom_point()

# Add Colour (Aesthetics)
ggplot(data=movies,mapping=aes(x=CriticRating,y=AudienceRating,
                               Genre,colour=Genre)) +
  geom_point()

# Add Size (Aesthetics) (Misleading!)
ggplot(data=movies,mapping=aes(x=CriticRating,y=AudienceRating,
                               Genre,colour=Genre,size=Genre)) +
  geom_point()

# Add Size (Aesthetics) (non-misleading)
ggplot(data=movies,mapping=aes(x=CriticRating,y=AudienceRating,
                               Genre,colour=Genre,size=BudgetMillions)) +
  geom_point()
# CHART 1 ACHIEVED (Can still be improved!)

# ----------------------------------------------------------------------------
# Layers
p <- ggplot(data=movies,mapping=aes(x=CriticRating,y=AudienceRating,
                                    Genre,colour=Genre,size=BudgetMillions))
p + geom_point()

# ----------------------------------------------------------------------------
# Overriding Aesthetics
q <- ggplot(data=movies,mapping=aes(x=CriticRating,y=AudienceRating,
                                    Genre,colour=Genre,size=BudgetMillions))
#Base
q + geom_point()

#E.g.1
q + geom_point(aes(size=CriticRating))

#E.g.2
q + geom_point(aes(colour=BudgetMillions))

#E.g.3 - size reduction
q + geom_line(size=1) + geom_point()

#E.g.4 - attention to axis labelling
q + geom_point(aes(x=BudgetMillions)) +
  xlab("Budget (Millions $$$)")
# CHART 2 ACHIEVED!

# -----------------------------------------------------------------------------
# Aesthetics Mapping vs. Setting
r <- ggplot(data=movies,mapping=aes(x=CriticRating,y=AudienceRating))
r + geom_point()

# Add Colour
# 1. Mapping
r + geom_point(aes(colour=Genre))

# 2. Setting
r + geom_point(colour="DarkGreen")

# ERROR
# r + geom_point(aes(colour="DarkGreen"))

# Add Size
# 1. Mapping
r + geom_point(aes(size=BudgetMillions))

# 2. Setting
r + geom_point(size=1)

# ERROR
r + geom_point(aes(size=1))

# ----------------------------------------------------------------------------
# Histograms and Density Charts
# Histograms
s <- ggplot(data=movies,aes(x=BudgetMillions))
s + geom_histogram(binwidth = 10)

# Add Colour
# WRONG: s + geom_histogram(binwidth = 10, aes(colour=Genre))
s + geom_histogram(binwidth = 10, aes(fill=Genre))

# Add Border
s + geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black")
# CHART 3 ACHIEVED! (Can be improved)

# Density Chart
s + geom_density(aes(fill=Genre))
s + geom_density(aes(fill=Genre), position="stack")

# ----------------------------------------------------------------------------
# Starting Layer Tips
t <- ggplot(data=movies,aes(x=AudienceRating))

t + geom_histogram(binwidth=10,fill="White",colour="Blue")

# Another way to achieve the same plot
# Easier way to create new charts
t <- ggplot(data=movies)
t + geom_histogram(aes(x=AudienceRating),
                   binwidth=10,fill="White",colour="Blue")
# CHART 4 ACHIEVED!

t + geom_histogram(aes(x=CriticRating),
                   binwidth=10,fill="White",colour="Blue")
# CHART 5 ACHIEVED!

# ----------------------------------------------------------------------------
# Statistical Transformations

# Generate Trends
#?geom_smooth()

u <- ggplot(data=movies,aes(x=CriticRating,y=AudienceRating,
                            colour=Genre))
u + geom_point()

u + geom_point() + geom_smooth()
u + geom_point() + geom_smooth(fill=NA)

# Box Plots
u <- ggplot(data=movies,aes(x=Genre,y=AudienceRating,
                            colour=Genre))
u + geom_boxplot()
u + geom_boxplot(size=0.75)
u + geom_boxplot(aes(fill=Genre),colour="Black")

# Pro Tip: Jitter instead of point for easier explanation of box plots
u + geom_boxplot(size=0.75) + geom_point()
u + geom_boxplot(size=0.75) + geom_jitter()
u + geom_jitter() + geom_boxplot(size=0.75,alpha=0.5)
# CHART 6 ACHIEVED!

# ----------------------------------------------------------------------------
# Facets
v <- ggplot(data=movies,aes(x=BudgetMillions))
v + geom_histogram(binwidth = 10,aes(fill=Genre),colour="Black")

# Using facets in Bar Charts
v + geom_histogram(binwidth = 10,aes(fill=Genre),
                   colour="Black") +
  facet_grid(Genre~.) # facet_grid(Genre~.) is not as visible

v + geom_histogram(binwidth = 10,aes(fill=Genre),
                   colour="Black") +
  facet_grid(Genre~., scales = "free")
  
# Using facets in Scatter Plots
w <- ggplot(data=movies,aes(x=CriticRating,y=AudienceRating,
                            colour=Genre))
w + geom_point(size=2)

w + geom_point(size=2) +
  facet_grid(.~Genre)

w + geom_point(size=2) +
  facet_grid(.~Year)

w + geom_point(size=2) +
  facet_grid(Genre~Year)

w + geom_point(size=2) +
  geom_smooth() +
  facet_grid(Genre~Year)

w + geom_point(aes(size=BudgetMillions)) +
  geom_smooth() +
  facet_grid(Genre~Year)
# Chart 1 (but will still improve!)
# Notice some charts reach -50 due to uncertainty intervals

# ----------------------------------------------------------------------------
# Coordinates
m <- ggplot(data=movies,aes(x=CriticRating,y=AudienceRating,
                            size=BudgetMillions,
                            colour=Genre))
m + geom_point()

# Let's see the movies with the highest ratings
m + geom_point() +
  xlim(50,100) +
  ylim(50,100)

# Cutting won't always work well
# In the histogram, it visibly cuts off data!
n <- ggplot(data=movies,aes(x=BudgetMillions))
n + geom_histogram(binwidth=10,aes(fill=Genre),colour="Black")
n + geom_histogram(binwidth=10,aes(fill=Genre),colour="Black") +
  ylim(0,50)

# Zoom in in a histogram
n + geom_histogram(binwidth=10,aes(fill=Genre),colour="Black") +
  coord_cartesian(ylim=c(0,50))

# Let's fix Chart 1
w + geom_point(aes(size=BudgetMillions)) +
  geom_smooth() +
  geom_hline(yintercept=50, linetype="dashed", color = "Black") +
  facet_grid(Genre~Year) +
  coord_cartesian(ylim=c(0,100))

# ----------------------------------------------------------------------------
# Themes
# Finally, we will improve Chart 3
o <- ggplot(data=movies,aes(x=BudgetMillions))

o + geom_histogram(binwidth = 10, aes(fill=Genre),
                   colour="Black")

# Axes Labels
o + geom_histogram(binwidth = 10, aes(fill=Genre),
                   colour="Black") +
  xlab("Money") +
  ylab("Number of Movies")

# Label Formatting
# Axes Labels
o + geom_histogram(binwidth = 10, aes(fill=Genre),
                   colour="Black") +
  xlab("Money") +
  ylab("Number of Movies") +
  theme(axis.title.x = element_text(colour="DarkGreen",size=30),
        axis.title.y = element_text(colour="Red",size=30))

# Tick Mark Formatting
o + geom_histogram(binwidth = 10, aes(fill=Genre),
                   colour="Black") +
  xlab("Money") +
  ylab("Number of Movies") +
  theme(axis.title.x = element_text(colour="DarkGreen",size=30),
        axis.title.y = element_text(colour="Red",size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20))

# Legend Formatting
o + geom_histogram(binwidth = 10, aes(fill=Genre),
                   colour="Black") +
  xlab("Money") +
  ylab("Number of Movies") +
  theme(axis.title.x = element_text(colour="DarkGreen",size=30),
        axis.title.y = element_text(colour="Red",size=30),
        
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20),
        
        legend.title = element_text(size=30),
        legend.text = element_text(size=20),
        legend.position = c(0.99,0.99),
        legend.justification = c(1,1))

# Plot Title Formatting
windowsFonts("Arial Black" = windowsFont("Arial Black"))

o + geom_histogram(binwidth = 10, aes(fill=Genre),
                   colour="Black") +
  xlab("Money") +
  ylab("Number of Movies") + 
  ggtitle("Movie Budget Distribution") +
  theme(axis.title.x = element_text(colour="DarkGreen",size=30),
        axis.title.y = element_text(colour="Red",size=30),
        
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20),
        
        legend.title = element_text(size=30),
        legend.text = element_text(size=20),
        legend.position = c(0.99,0.99),
        legend.justification = c(1,1),
        
        plot.title = element_text(colour="DarkBlue",
                                  size=40,
                                  hjust = 0.5,
                                  family="Arial Black"))

# You can change fonts with the "extrafont" package!