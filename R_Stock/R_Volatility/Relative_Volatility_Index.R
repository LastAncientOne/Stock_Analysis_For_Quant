# Load the required library
library(quantmod)

# Function to calculate Relative Volatility Index (RVI)
calculate_RVI <- function(returns, n = 14) {
  volatility <- runSD(returns, n = n) # Calculate n-period standard deviation of returns
  sma_volatility <- SMA(volatility, n = n) # Calculate n-period simple moving average of volatility
  rvi <- volatility / sma_volatility # Calculate Relative Volatility Index
  return(rvi)
}

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

# Calculate RVI with default lookback period of 14
rvi_values <- calculate_RVI(returns)

# Drop NA values
rvi_values <- na.omit(rvi_values)

# View the RVI values
print(rvi_values)
