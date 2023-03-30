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

# Calculate the Bernardo Ledoit Ratio
bernardoledoit_ratio <- BernardoLedoitRatio(returns, Rf = 0)

# Print the Bernardo Ledoit Ratio
print(symbol)
print(bernardoledoit_ratio)
cat(symbol, ': ', bernardoledoit_ratio)


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

# Calculate the Bernardo Ledoit Ratio for each stock
bernardoledoit_ratios <- data.frame()
for (ticker in tickers) {
  bernardoledoit_ratio <- BernardoLedoitRatio(returns[[ticker]], Rf=0)
  bernardoledoit_ratios <- rbind(bernardoledoit_ratios, data.frame(Symbol = ticker, BernardoLedoit_Ratio = bernardoledoit_ratio))
}

# Print the table of Bernardo Ledoit Ratio
print(bernardoledoit_ratios)