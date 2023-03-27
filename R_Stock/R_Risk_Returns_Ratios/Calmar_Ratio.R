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

# Calculate the Calmar Ratio
calmar_ratio <- CalmarRatio(returns)

# Print the Calmar Ratio
print(symbol)
print(calmar_ratio)
cat(symbol, ': ', calmar_ratio)


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

# Calculate the Calmar Ratio for each stock
calmar_ratios <- data.frame()
for (ticker in tickers) {
  calmar_ratio <- CalmarRatio(returns[[ticker]])
  calmar_ratios <- rbind(calmar_ratios, data.frame(Symbol = ticker, Calmar_Ratio = calmar_ratio))
}

# Print the table of Calmar Ratios
print(calmar_ratios)
