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

# Calculate kurtosis and relative kurtosis
kurt <- kurtosis(returns)
normal_kurt <- 3  # Kurtosis of a normal distribution
relative_kurt <- kurt / normal_kurt

# Print results
print(symbol)
cat("Kurtosis:", kurt, "\n")
cat("Relative Kurtosis:", relative_kurt, "\n")


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

# Calculate the relative kurtosis for each stock's returns
relative_kurtosis <- numeric(length(tickers))
for (i in seq_along(tickers)) {
  kurt <- kurtosis(returns[[i]])
  norm_kurt <- 3  # Kurtosis of a normal distribution
  relative_kurtosis[i] <- kurt / norm_kurt
}

# Create a data frame to store the results
results <- data.frame(
  Ticker = tickers,
  Relative_Kurtosis = relative_kurtosis
)

print(results)