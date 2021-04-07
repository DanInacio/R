#4.8 Data Analytics

#Salary
MyPlot(Salary)
MyPlot(Salary/Games)
MyPlot(Salary/FieldGoals)

#In-Game Metrics
MyPlot(MinutesPlayed)
MyPlot(Points)

#At this point, we know the injuries input anomalies into the data

#In/Game Metrics Normalized
MyPlot(FieldGoals/Games)
MyPlot(FieldGoals/FieldGoalAttempts)
MyPlot(FieldGoalAttempts/Games)
MyPlot(Points/Games)

#Time Played
MyPlot(MinutesPlayed/Games) # Interesting, they play less and less
MyPlot(Games)

#Scoring Speed
MyPlot(FieldGoals/MinutesPlayed)

#Player Style
MyPlot(Points/FieldGoals)
