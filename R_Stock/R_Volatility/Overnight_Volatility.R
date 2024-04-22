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

# Calculate overnight returns
overnight_returns <- log(Op(data) / Cl(data))

# Calculate overnight volatility
n <- length(overnight_returns)
avg_overnight_returns <- mean(overnight_returns)
overnight_volatility <- sqrt(1/(n-1) * sum((overnight_returns - avg_overnight_returns)^2))

# Print the result
cat("Overnight Volatility:", overnight_volatility)
