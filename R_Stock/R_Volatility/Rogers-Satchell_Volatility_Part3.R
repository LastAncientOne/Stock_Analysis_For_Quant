# Load the required library
library(quantmod)

# Function to calculate Rogers Satchell Volatility
calculate_RS_volatility <- function(symbol, start_date, end_date) {
  # Fetch historical price data
  data <- getSymbols(symbol, from = start_date, to = end_date, auto.assign = FALSE)
  
  # Calculate daily returns
  returns <- dailyReturn(data)
  
  # Calculate necessary variables
  n <- nrow(returns)
  high <- Hi(data)
  low <- Lo(data)
  close <- Cl(data)
  open <- Op(data)
  
  # Calculate Rogers Satchell Volatility
  RS_volatility <- sqrt((1/n) * sum(( (high - close) * (high - open) + (low - close) * (low - open) )))
  
  return(RS_volatility)
}

# Individual symbol
symbol <- "AAPL"

# Set the start and end date of the analysis
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Calculate Rogers Satchell Volatility
RS_volatility <- calculate_RS_volatility(symbol, start_date, end_date)
print(paste("Rogers Satchell Volatility for", symbol, ":", RS_volatility))
