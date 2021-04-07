#5.7. Visualizing with Quick Plot, Part 2
qplot(data=mergedDF,x=Internet.users,y=Birth.rate,size=I(4), colour=Region)

#a. Shapes
qplot(data=mergedDF,x=Internet.users,y=Birth.rate,size=I(4), colour=Region,
      shape=I(17))
qplot(data=mergedDF,x=Internet.users,y=Birth.rate,size=I(4), colour=Region,
      shape=I(2))
qplot(data=mergedDF,x=Internet.users,y=Birth.rate,size=I(4), colour=Region,
      shape=I(15))
qplot(data=mergedDF,x=Internet.users,y=Birth.rate,size=I(4), colour=Region,
      shape=I(23))

#b. Transparency
qplot(data=mergedDF,x=Internet.users,y=Birth.rate,size=I(4), colour=Region,
      shape=I(19),alpha=I(0.5))

#c. Title
qplot(data=mergedDF,x=Internet.users,y=Birth.rate,size=I(5), colour=Region,
      shape=I(19),alpha=I(0.5),main="Birth Rate vs. Internet Users")
