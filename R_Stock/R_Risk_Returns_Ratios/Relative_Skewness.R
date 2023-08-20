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

# Calculate the skewness of the stock returns
skewness_stock <- skewness(returns, na.rm = TRUE)

# Load benchmark data (e.g., S&P 500)
benchmark_symbol <- "SPY"
getSymbols(benchmark_symbol, src = "yahoo", from = start_date, to = end_date)
benchmark_returns <- dailyReturn(Cl(get(benchmark_symbol)))

# Calculate the skewness of the benchmark returns
skewness_benchmark <- skewness(benchmark_returns, na.rm = TRUE)

# Calculate relative skewness
relative_skewness <- skewness_stock - skewness_benchmark

# Print the results
cat("Skewness of", symbol, "returns:", skewness_stock, "\n")
cat("Skewness of", benchmark_symbol, "returns:", skewness_benchmark, "\n")
cat("Relative skewness:", relative_skewness, "\n")

# Interpretation
if (relative_skewness > 0) {
  cat(symbol, "returns are more positively skewed than the benchmark.")
} else if (relative_skewness < 0) {
  cat(symbol, "returns are more negatively skewed than the benchmark.")
} else {
  cat("Skewness of", symbol, "returns is similar to the benchmark.")
}

# Multiple Stock symbols
# Define the stock symbols of the library
tickers <- c("BAC", "GS", "C", "WFC", "JPM")


# Dates
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Get the stock data
getSymbols(tickers, from = start_date, to = end_date)

# Calculate the daily returns for each stock
returns <- list()
for (ticker in tickers) {
  returns[[ticker]] <- dailyReturn(Cl(get(ticker)))
}

# Combine the returns into a data frame
returns_df <- do.call(cbind, returns)

# Calculate the benchmark return (you can replace this with any benchmark you want)
benchmark <- dailyReturn(Cl(get("SPY")))

# Calculate relative skewness for each stock
relative_skewness <- sapply(1:length(tickers), function(i) {
  skewness(returns_df[, i]) - skewness(benchmark)
})

# Print the relative skewness values
result <- data.frame(Ticker = tickers, Relative_Skewness = relative_skewness)
print(result)