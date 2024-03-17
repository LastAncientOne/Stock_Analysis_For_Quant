# Load the required library
library(quantmod)

# Individual symbol
symbol <- "AAPL"

# Set the start and end date of the analysis
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Get the historical data
getSymbols(symbol, from = start_date, to = end_date)
data <- get(symbol)

# Calculate the daily returns
returns <- dailyReturn(data$AAPL.Close)

# Extract the weekdays from the index (assuming the index is in date format)
weekdays <- as.factor(weekdays(index(returns)))

# Add the weekdays as a column to the returns data
returns$Weekday <- weekdays

# Calculate standard deviation of returns for each day of the week
volatility_by_day <- aggregate(returns[, 1], by = list(returns$Weekday), FUN = sd)

# Identify the day with the highest volatility
most_volatile_day <- volatility_by_day[which.max(volatility_by_day$x), ]

# Print the most volatile day
print(most_volatile_day)