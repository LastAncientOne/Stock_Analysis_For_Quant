# Load the required library
library(quantmod)
library(PerformanceAnalytics)

# Individual symbol
# Set the start and end date of the analysis
symbol <- "AAPL"
start_date <- as.Date("2018-01-01")
end_date <- Sys.Date()

# Get Data
getSymbols(symbol, src = "yahoo", from = start_date, to = end_date)

# Calculate the daily returns
returns <- dailyReturn(Cl(get(symbol)))

# Calculate the Kappa
kappa <- Kappa(returns, MAR = 0.001, l=2)

# Print the Kappa 
print(symbol)
print(kappa)
cat(symbol, ': ', kappa)


# Multiple Stock symbols
# Define the stock symbols of the library
tickers <- c("BAC", "GS", "C", "WFC", "JPM")

# Dates
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Get the stock data
getSymbols(tickers , from = start_date, to = end_date)

# Calculate the daily returns for each stock
returns <- list()
for (ticker in tickers) {
  returns[[ticker]] <- dailyReturn(Cl(get(ticker)))
}

# Calculate the Kappa for each stock
kappas <- data.frame()
for (ticker in tickers) {
  kappa <- Kappa(returns[[ticker]], MAR = 0.001, l=2)
  kappas <- rbind(kappas, data.frame(Symbol = ticker, Kappa = kappa))
}

# Print the table of Kappa
print(kappas)