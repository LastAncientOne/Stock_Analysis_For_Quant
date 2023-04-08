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

# Get the Benchmark data
benchmark <- getSymbols("SPY", from = start_date, to = end_date)
Rb <- dailyReturn(Cl(get(benchmark)))

# Calculate the UpDown Ratio
updown_ratio <- UpDownRatios(returns, Rb)

# Print the UpDown Ratio
print(symbol)
print(updown_ratio)
cat(symbol, ': ', updown_ratio)


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

# Calculate the UpDown Ratio for each stock
updown_ratios <- data.frame()
for (ticker in tickers) {
  updown_ratio <- UpDownRatios(returns[[ticker]], Rb)
  updown_ratios <- rbind(updown_ratios, data.frame(Symbol = ticker, UpDown_Ratio = updown_ratio))
}

# Print the table of UpDown Ratio
print(updown_ratios)