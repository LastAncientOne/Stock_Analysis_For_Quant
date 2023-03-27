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

# Calculate the Kelly Ratio
kelly_ratio <- KellyRatio(returns, Rf = 0, method = "half")

# Print the Kelly Ratio
print(symbol)
print(kelly_ratio)
cat(symbol, ': ', kelly_ratio)


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

# Calculate the Kelly Ratio for each stock
kelly_ratios <- data.frame()
for (ticker in tickers) {
  kelly_ratio <- KellyRatio(returns[[ticker]])
  kelly_ratios <- rbind(kelly_ratios, data.frame(Symbol = ticker, Kelly_Ratio = kelly_ratio))
}

# Print the table of Kelly Ratios
print(kelly_ratios)
