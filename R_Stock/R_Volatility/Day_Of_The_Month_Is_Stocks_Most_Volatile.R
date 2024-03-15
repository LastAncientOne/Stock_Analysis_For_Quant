# Load the required libraries
library(quantmod)
library(dplyr)

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

# Calculate volatility using standard deviation
volatility <- sd(returns, na.rm = TRUE)

# Drop NA values
volatility <- na.omit(volatility)

# View historical volatility
print(volatility)


# Extract day of the month from the date index
day_of_month <- as.numeric(format(index(returns), "%d"))

# Calculate standard deviation of returns for each day of the month
volatility_by_day <- tapply(coredata(returns), day_of_month, sd)

# Find the day with the highest volatility
most_volatile_day <- which.max(volatility_by_day)

# Print the most volatile day
cat("The most volatile day of the month for", symbol, "is day", most_volatile_day, "\n")

# Extract month from date
returns$Month <- format(index(returns), "%Y-%m")

# Aggregate returns by month and calculate standard deviation (volatility)
monthly_volatility <- aggregate(coredata(returns), by = list(returns$Month), FUN = sd)

# Find the month with the highest volatility
most_volatile_month <- monthly_volatility[which.max(monthly_volatility[,2]), 1]

# Print the most volatile month
print(paste("The most volatile month for", symbol, "is:", most_volatile_month))