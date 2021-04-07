#4.4. Visualizing with matplot()
?matplot()
?legend()

matplot(FieldGoals) # Plotting each column. We want the rows!

#Transpose the matrix to swap rows and columns
#Now the columns represent the players
matplot(t(FieldGoals))

matplot(t(FieldGoals),type="b",pch=15:18,col=c(1:4,6),
        xlab="Season Year",ylab="Field Goals")
legend("bottomleft",inset=0.005,legend=Players,pch=15:18,col=c(1:4,6),horiz=F)

#Normalized Goals, i.e. Field Goals per Game
matplot(t(FieldGoals/Games),type="b",pch=15:18,col=c(1:4,6),
        xlab="Season Year",ylab="Field Goals")
legend("bottomleft",inset=0.005,legend=Players,pch=15:18,col=c(1:4,6),horiz=F)

#Normalized Accuracy, i.e. Field Goals per FieldGoalAttempts
matplot(t(FieldGoals/FieldGoalAttempts),type="b",pch=15:18,col=c(1:4,6),
        xlab="Season Year",ylab="Field Goals")
legend("bottomleft",inset=0.005,legend=Players,pch=15:18,col=c(1:4,6),horiz=F)

#Salary per minute
matplot(t(Salary/MinutesPlayed),type="b",pch=15:18,col=c(1:4,6),
        xlab="Season Year",ylab="Field Goals")
legend("bottomleft",inset=0.005,legend=Players,pch=15:18,col=c(1:4,6),horiz=F)

#Points per Game
matplot(t(Points/Games),type="b",pch=15:18,col=c(1:4,6),
        xlab="Season Year",ylab="Field Goals")
legend("bottomleft",inset=0.005,legend=Players,pch=15:18,col=c(1:4,6),horiz=F)