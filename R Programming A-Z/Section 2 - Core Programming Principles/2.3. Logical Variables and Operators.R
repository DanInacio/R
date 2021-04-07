#2.3. Logical Variables and Operators

#Logical:
# TRUE T
# FALSE F
# ==
# !=
# <
# >
# <=
# >=
# !
# |
# &
# isTRUE(x)

4<5
10>100
4==5
5!=6

result <- 4<5
result
typeof(result)

result2 <- !result
result2

# 1 OR the other must be true
result | result2

# 1 AND the other must be true
result & result2

isTRUE(result)