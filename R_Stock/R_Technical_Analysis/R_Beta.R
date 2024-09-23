library(quantmod)
library(ggplot2)
library(gridExtra)
library(TTR)

# Define parameters
symbol <- 'AAPL'
market <- 'SPY'
start <- '2018-08-01'
end <- '2019-01-01'
n <- 5

# Get stock and market data
getSymbols(symbol, from = start, to = end, adjust = TRUE)
getSymbols(market, from = start, to = end, adjust = TRUE)

# Extract adjusted close prices
stock_data <- Cl(get(symbol))
market_data <- Cl(get(market))

# Calculate returns
stock_returns <- dailyReturn(stock_data)
market_returns <- dailyReturn(market_data)

# Calculate rolling covariance and variance
covar <- rollapply(merge(stock_returns, market_returns), width = n, FUN = function(x) cov(x[,1], x[,2]), by.column = FALSE, align = 'right')
variance <- rollapply(market_returns, width = n, FUN = var, align = 'right')

# Calculate Beta Indicator
beta_indicator <- covar / variance

# Combine data
Stock <- merge(stock_data, stock_returns, market_data, market_returns, beta_indicator)
colnames(Stock) <- c("AAPL.Close", "AAPL.Returns", "Market.Close", "Market.Returns", "Beta")

# Plot Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price") +
  theme(plot.title = element_text(hjust = 0.5))

# Plot Beta Indicator
beta_chart <- ggplot(Stock, aes(x = index(Stock), y = Beta)) +
  geom_line(color = "blue") +
  labs(title = "Beta Indicator",
       x = "Date",
       y = "Beta") +
  theme(plot.title = element_text(hjust = 0.5))

# Arrange charts using grid
grid.arrange(closing_price_chart, beta_chart, ncol = 1)
