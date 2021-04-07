#5.5. Quick Plot()
?qplot()

# Number of countries with a certain number of internet users
qplot(data=stats,x=Internet.users)

# I ensures it is not mapped as a legend, in the quick plot
qplot(data=stats,x=Income.Group,y=Birth.rate,
      size=I(3), colour=I("blue"))

qplot(data=stats,x=Income.Group,y=Birth.rate,
      geom="boxplot")

qplot(data=stats,x=Country.Name,y=Birth.rate,
      size=I(3), colour=I("red"))

stats[stats$Birth.rate>35 & stats$Income.Group=="High income",]
stats[stats$Birth.rate>35 & stats$Income.Group=="Upper middle income",]

# ------------------------------------
# VISUALIZING WITH QUICK PLOT

qplot(data=stats,x=Internet.users,y=Birth.rate)
qplot(data=stats,x=Internet.users,y=Birth.rate,size=I(3))
qplot(data=stats,x=Internet.users,y=Birth.rate,size=I(4), colour=I("red"))
qplot(data=stats,x=Internet.users,y=Birth.rate,size=I(4), colour=Income.Group)