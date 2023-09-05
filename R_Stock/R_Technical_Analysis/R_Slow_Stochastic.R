# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Slow Stochastic
stoch_period <- 14
Stock$H <- runMax(Stock$AAPL.High, n = stoch_period)
Stock$L <- runMin(Stock$AAPL.Low, n = stoch_period)
Stock$SlowK <- 100 * (Stock$AAPL.Close - Stock$L) / (Stock$H - Stock$L)
Stock$SlowD <- SMA(Stock$SlowK, n = 3)

# Create separate charts for Closing Price and Slow Stochastic
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

stoch_chart <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = SlowK), color = 'blue', linetype = 'solid') +
  geom_line(aes(y = SlowD), color = 'red', linetype = 'dashed') +
  labs(title = "Slow Stochastic",
       x = "Date",
       y = "Value") +
  scale_y_continuous(limits = c(0, 100))

# Arrange charts using grid
grid.arrange(closing_price_chart, stoch_chart, ncol = 1)
