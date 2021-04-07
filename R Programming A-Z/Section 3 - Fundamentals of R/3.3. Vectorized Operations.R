#3.3. Vectorized Operations
x <- rnorm(5)
x

# R-Specific Loop
for(i in x)
{
  print(i)
}

print(x[1])
print(x[2])
print(x[j])

#Conventional Loop
for(j in 1:5)
{
  print(x[j])
}

#------------ 2nd Part

N <- 100
a <- rnorm(N)
b <- rnorm(N)

#Vectorized Approach
c <- a*b

#De-vectorized Approach
d <- rep(NA,N)
for(i in 1:N)
{
  d[i] <- a[i]*b[i]
}