library(quantmod)
library(PerformanceAnalytics)

# Individual symbol
# Set the start and end date of the analysis
symbol <- "AAPL"
start_date <- as.Date("2018-01-01")
end_date <- Sys.Date()

# Get Data
getSymbols(symbol, src = "yahoo", from = start_date, to = end_date)

# Get the Benchmark data
benchmark <- getSymbols("SPY", from = start_date, to = end_date)
Rb <- dailyReturn(Cl(get(benchmark)))

# Calculate the daily returns
returns <- dailyReturn(Cl(get(symbol)))

# Calculate the Appraisal Ratio
appraisal_ratio <- AppraisalRatio(returns, Rb, scale = NA)

# Print the Appraisal Ratio
print(symbol)
print(appraisal_ratio)
cat(symbol, ': ', appraisal_ratio)


# Define a vector of stock tickers
tickers <- c("BAC", "GS", "C", "WFC", "JPM")

# Dates
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Get the stock data
getSymbols(tickers , from = start_date, to = end_date)

# Get the Benchmark data
benchmark <- getSymbols("SPY", from = start_date, to = end_date)
Rb <- dailyReturn(Cl(get(benchmark)))

# Calculate the daily returns for each stock
returns <- list()
for (ticker in tickers) {
  returns[[ticker ]] <- dailyReturn(Cl(get(ticker)))
}

# Calculate the Appraisal Ratio for each stock
appraisal_ratios <- data.frame()
for (ticker in tickers) {
  appraisal_ratio <- AppraisalRatio(returns[[ticker]], Rb)
  appraisal_ratios <- rbind(appraisal_ratios, data.frame(Symbol = ticker, Appraisal_ratio = appraisal_ratio))
}

# Print the table of Appraisal Ratios
print(appraisal_ratios)
