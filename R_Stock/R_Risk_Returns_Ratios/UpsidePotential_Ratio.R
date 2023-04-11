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

# Calculate the UpsidePotential Ratio
upsidepotential_ratio <- UpsidePotentialRatio(returns)

# Print the UpsidePotential Ratio
print(symbol)
print(upsidepotential_ratio)
cat(symbol, ': ', upsidepotential_ratio)


# Define a vector of stock tickers
tickers <- c("BAC", "GS", "C", "WFC", "JPM")

# Dates
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Get the stock data
getSymbols(tickers , from = start_date, to = end_date)

# Calculate the daily returns for each stock
returns <- list()
for (ticker in tickers) {
  returns[[ticker ]] <- dailyReturn(Cl(get(ticker )))
}

# Calculate the UpsidePotential Ratio for each stock
upsidepotential_ratios <- data.frame()
for (ticker in tickers) {
  upsidepotential_ratio <- UpsidePotentialRatio(returns[[ticker]])
  upsidepotential_ratios <- rbind(upsidepotential_ratios, data.frame(Symbol = ticker, UpsidePotential_ratio = upsidepotential_ratio))
}

# Print the table of UpsidePotential Ratios
print(upsidepotential_ratios)
