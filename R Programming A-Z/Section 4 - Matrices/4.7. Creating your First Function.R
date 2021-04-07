#4.7. Creating your First Function

#Note, if you initialize a value in the function,
#it is used as default if not specified
MyPlot <- function(Data,rows=1:10,columns=1:10){
 
  Data <- t(Data[rows,columns,drop=F])
  matplot(Data,type="b",pch=15:18,col=c(1:4,6),
          xlab="Season Year",ylab="Field Goals")
  legend("bottomleft",inset=0.005,legend=Players[rows],pch=15:18,col=c(1:4,6),horiz=F)
  
  Data
}

MyPlot(MinutesPlayed,1:5,)
MyPlot(Games)
MyPlot(Salary)