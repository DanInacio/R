#Visualizing subsets (Transpose the matrix so columns has the relevant data)
#Now the columns represent the players
Data <- t(MinutesPlayed[1:2,6:10])
matplot(Data,type="b",pch=15:18,col=c(1:4,6),
        xlab="Season Year",ylab="Field Goals")
legend("bottomleft",inset=0.005,legend=Players[1:2],pch=15:18,col=c(1:4,6),horiz=F)

Data <- t(MinutesPlayed[1:3,])
matplot(Data,type="b",pch=15:18,col=c(1:4,6),
        xlab="Season Year",ylab="Field Goals")
legend("bottomleft",inset=0.005,legend=Players[1:3],pch=15:18,col=c(1:4,6),horiz=F)

Data <- t(MinutesPlayed[1,,drop=F])
matplot(Data,type="b",pch=15:18,col=c(1:4,6),
        xlab="Season Year",ylab="Field Goals")
legend("bottomleft",inset=0.005,legend=Players[1],pch=15:18,col=c(1:4,6),horiz=F)

rm(Data)
