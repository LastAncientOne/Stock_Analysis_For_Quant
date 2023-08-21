# Load the required library
library(quantmod)

# Set the symbol and date range
symbol <- "AAPL"
start_date <- as.Date("2018-01-01")
end_date <- Sys.Date()

# Get Data
getSymbols(symbol, src = "yahoo", from = start_date, to = end_date)

# Calculate daily returns
returns <- dailyReturn(Cl(get(symbol)))

# Calculate CAGR
first_price <- Cl(get(symbol))[[1]]
last_price <- Cl(get(symbol))[[nrow(get(symbol))]]
years <- as.numeric(difftime(end_date, start_date, units = "days") / 252)
cagr <- (last_price / first_price)^(1/years) - 1

# Print CAGR
cat("Compound Annual Growth Rate (CAGR):", symbol, round(cagr * 100, 2), "%\n")


# Multiple Stock symbols
# Define the stock symbols of the library
tickers <- c("BAC", "GS", "C", "WFC", "JPM")

# Dates
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Initialize an empty list to store CAGR values for each stock
cagr_values <- vector("numeric", length(tickers))

for (i in seq_along(tickers)) {
  symbol <- tickers[i]
  
  # Get Data
  getSymbols(symbol, src = "yahoo", from = start_date, to = end_date)
  
  # Calculate daily returns
  returns <- dailyReturn(Cl(get(symbol)))
  
  # Calculate CAGR
  first_price <- Cl(get(symbol))[[1]]
  last_price <- Cl(get(symbol))[[nrow(get(symbol))]]
  years <- as.numeric(difftime(end_date, start_date, units = "days") / 252)
  cagr <- ((last_price / first_price)^(1/years)) - 1
  
  # Store CAGR value in the list
  cagr_values[i] <- cagr
}

# Print CAGR values for each stock
for (i in seq_along(tickers)) {
  cat("Compound Annual Growth Rate (CAGR):", tickers[i], ":", round(cagr_values[i] * 100, 2), "%\n")
}