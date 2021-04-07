#Law of Large Numbers
#expectedX <- 68.2
#number <- 0

#for(i in 1:10000)
#{
#  X<- rnorm(1)
#  if(X>-1 & X<1)
#  {
#    number <- number+1
#  }
#}

# Compare to 68.2
N <- 10000 # Sample size
counter <- 0 # Reset counter

for(i in rnorm(N))
{
  if(i>-1 & i<1)
  {
    counter <- counter +1
  }
}
answer <- counter/N
answer