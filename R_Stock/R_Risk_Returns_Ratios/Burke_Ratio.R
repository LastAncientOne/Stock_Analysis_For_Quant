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

# Calculate the Burke Ratio
burke_ratio <- BurkeRatio(returns, Rf = 0)

# Print the Burke Ratio
print(symbol)
print(burke_ratio)
cat(symbol, ': ', burke_ratio)


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

# Calculate the Burke Ratio for each stock
burke_ratios <- data.frame()
for (ticker in tickers) {
  burke_ratio <- BurkeRatio(returns[[ticker]], Rf=0)
  burke_ratios <- rbind(burke_ratios, data.frame(Symbol = ticker, Burke_Ratio = burke_ratio))
}

# Print the table of Burke Ratio
print(burke_ratios)
