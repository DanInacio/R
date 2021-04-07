#3.2. Using brackets
x <- c(1,123,534,13,4) # Combine
y <- seq(201,250,11) # Sequence
z <- rep("Hi",3) # Replicate

w <- c("a","b","c","d","e")
w

w[1]       # Pos1
w[-1]      # All except Pos1
v <- w[-3] # All except Pos3
w[1:3]     # Pos1 to Pos3
w[3:5]     # Pos3 to Pos5
w[c(1,3,5)]# Pos1, 3 and 5
w[c(-2,-4)]# All except Pos2 and 4
w[-3:-5]   # All except last 3
w[7]       # NA