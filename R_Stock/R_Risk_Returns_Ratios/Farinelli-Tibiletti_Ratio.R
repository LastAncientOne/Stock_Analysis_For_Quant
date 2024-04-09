# Load the required library
library(quantmod)

# Individual symbol
symbol <- "AAPL"

# Set the start and end date of the analysis
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Get the historical data
getSymbols(symbol, from = start_date, to = end_date)
data <- get(symbol)

# Calculate the daily returns
returns <- dailyReturn(data$AAPL.Close)

# Calculate annualized return
avg_daily_return <- mean(returns, na.rm = TRUE)
annualized_return <- (1 + avg_daily_return)^252 - 1

# Calculate maximum drawdown
max_drawdown <- function(rets) {
  peak <- cummax(rets)
  drawdown <- (peak - rets) / peak
  max_drawdown <- max(drawdown, na.rm = TRUE)
  return(max_drawdown)
}

maximum_drawdown <- max_drawdown(data$AAPL.Close)

# Calculate Farinelli-Tibiletti ratio
farinelli_tibiletti_ratio <- annualized_return / maximum_drawdown

# Print the results
print(paste("Annualized Return:", annualized_return))
print(paste("Maximum Drawdown:", maximum_drawdown))
print(paste("Farinelli-Tibiletti Ratio:", farinelli_tibiletti_ratio))
