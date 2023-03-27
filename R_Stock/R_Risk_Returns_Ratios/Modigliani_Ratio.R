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

# Calculate the Modigliani-Modigliani Ratio
modigliani_ratio <- Modigliani(returns, Rb, Rf = 0.01)

# Print the Modigliani-Modigliani Ratio
print(symbol)
print(modigliani_ratio)
cat(symbol, ': ', modigliani_ratio)


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

# Calculate the Modigliani-Modigliani Ratio for each stock
modigliani_ratios <- data.frame()
for (ticker in tickers) {
  modigliani_ratio <- Modigliani(returns[[ticker]], Rb, Rf = 0.01)
  modigliani_ratios <- rbind(modigliani_ratios, data.frame(Symbol = ticker, Modigliani_Ratio = modigliani_ratio))
}

# Print the table of Modigliani-Modigliani Ratios
print(modigliani_ratios)
