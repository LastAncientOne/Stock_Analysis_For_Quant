# Load the required library
library(quantmod)

# Function to calculate Rogers Satchell Volatility
RS_volatility <- function(symbol, start_date, end_date) {
  # Fetch historical data
  data <- getSymbols(symbol, from = start_date, to = end_date, auto.assign = FALSE)
  
  # Calculate high-low-close-open differences
  HLCO_diff <- (Hi(data) - Cl(data)) * (Hi(data) - Op(data)) + (Lo(data) - Cl(data)) * (Lo(data) - Op(data))
  
  # Calculate square root of the sum of squared differences
  sigma_RS_sq <- sqrt((1/nrow(data)) * sum(HLCO_diff))
  
  return(sigma_RS_sq)
}

# Individual symbol
symbol <- "AAPL"

# Set the start and end date of the analysis
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Calculate Rogers Satchell Volatility
RS_vol <- RS_volatility(symbol, start_date, end_date)
print(RS_vol)


