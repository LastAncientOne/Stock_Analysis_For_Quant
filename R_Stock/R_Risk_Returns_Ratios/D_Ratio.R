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

# Calculate the D Ratio
d_ratio <- DRatio(returns)

# Print the D Ratio
print(symbol)
print(d_ratio)
cat(symbol, ': ', d_ratio)


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

# Calculate the D Ratio for each stock
d_ratios <- data.frame()
for (ticker in tickers) {
  d_ratio <- DRatio(returns[[ticker]])
  d_ratios <- rbind(d_ratios, data.frame(Symbol = ticker, D_Ratio = d_ratio))
}

# Print the table of D Ratio
print(d_ratios)
