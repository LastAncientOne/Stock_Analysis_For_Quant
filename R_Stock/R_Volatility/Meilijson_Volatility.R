# Load the required library
library(quantmod)

# Individual symbol
symbol <- "AAPL"

# Set the start and end date of the analysis
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Get the historical data
getSymbols(symbol, from = start_date, to = end_date)

# Calculate daily simple returns
returns <- Delt(Cl(AAPL))

# Drop NA values
returns <- returns[!is.na(returns)]

# Calculate the Meilijson estimator
meilijson_estimator <- sum(abs(returns)) / length(returns)

# Print the Meilijson estimator
print(meilijson_estimator)

