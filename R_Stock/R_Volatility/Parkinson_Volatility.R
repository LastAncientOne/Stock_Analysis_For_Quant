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

# Calculate Parkinson Volatility
high_low <- log(data$AAPL.High / data$AAPL.Low)^2
parkinson_volatility <- sqrt((1 / (4 * log(2))) * high_low)

# View Parkinson Volatility
head(parkinson_volatility)