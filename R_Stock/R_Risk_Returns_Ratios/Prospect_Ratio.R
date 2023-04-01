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

# Calculate the Prospect Ratio
prospect_ratio <- ProspectRatio(returns, MAR=0)

# Print the Prospect Ratio
print(symbol)
print(prospect_ratio)
cat(symbol, ': ', prospect_ratio)


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

# Calculate the Prospect Ratio for each stock
prospect_ratios <- data.frame()
for (ticker in tickers) {
  prospect_ratio <- ProspectRatio(returns[[ticker]], MAR=0)
  prospect_ratios <- rbind(prospect_ratios, data.frame(Symbol = ticker, Prospect_Ratio = prospect_ratio))
}

# Print the table of Prospect Ratios
print(prospect_ratios)