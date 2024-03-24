# Load required libraries
library(quantmod)

# Define the symbol and dates
symbol <- "AAPL"
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Get historical data
getSymbols(symbol, from = start_date, to = end_date)
data <- get(symbol)

# Calculate Rogers-Satchell volatility
rs_volatility <- function(data) {
  close <- Cl(data)
  high <- Hi(data)
  low <- Lo(data)
  open <- Op(data)
  
  returns <- log(close / lag(open))  # Calculate logarithmic returns
  hl <- log(high / low)  # Calculate log of high/low
  
  rs_vol <- sqrt(0.5 * (returns^2 + hl^2 - (2 * log(2)) * returns * hl))  # Calculate Rogers-Satchell volatility
  
  return(rs_vol)
}

# Calculate Rogers-Satchell volatility for AAPL
rs_vol <- rs_volatility(data)
print(rs_vol)

