#Basketball Free Throws
MyPlot <- function(Data,rows=1:10,columns=1:10){
  
  Data <- t(Data[rows,columns,drop=F])
  matplot(Data,type="b",pch=15:18,col=c(1:4,6),
          xlab="Season Year",ylab="Field Goals")
  legend("bottomleft",inset=0.005,legend=Players[rows],pch=15:18,col=c(1:4,6),horiz=F)
  
  Data
}

#Free Throw Attempts per Game
MyPlot(FreeThrowAttempts/Games)

#Free Throw Accuracy
MyPlot(FreeThrows/FreeThrowAttempts)

#Play Style excluding free throws
MyPlot((Points-FreeThrows)/FieldGoals)
