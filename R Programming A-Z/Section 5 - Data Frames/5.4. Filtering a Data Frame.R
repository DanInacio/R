#5.4. Filtering a Data Frame

# Filtering is about rows
stats
head(stats)
filter <- stats$Internet.users < 2

# Countries with less than 2 internet users
stats[filter,]

# Countries with birth rate > 40
stats[stats$Birth.rate > 40,]

# Countries with internet users < 2 AND birth rate > 40
stats[stats$Internet.users<2 & stats$Birth.rate > 40,]

# Countries with High income
levels(stats$Income.Group)
stats[stats$Income.Group == "High income",]

# Malta Country
stats[stats$Country.Name=="Malta",]