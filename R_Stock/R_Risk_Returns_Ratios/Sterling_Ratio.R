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

# Calculate the Sterling Ratio
sterling_ratio <- SterlingRatio(returns)

# Print the Sterling Ratio
print(symbol)
print(sterling_ratio)
cat(symbol, ': ', sterling_ratio)


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

# Calculate the Sterling Ratio for each stock
sterling_ratios <- data.frame()
for (ticker in tickers) {
  sterling_ratio <- SterlingRatio(returns[[ticker]], excess = 0.1)
  sterling_ratios <- rbind(sterling_ratios, data.frame(Symbol = ticker, sterling_Ratio = sterling_ratio))
}

# Print the table of Sterling Ratio
print(sterling_ratios)