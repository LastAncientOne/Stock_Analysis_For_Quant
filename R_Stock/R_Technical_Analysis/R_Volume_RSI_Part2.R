# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(TTR)  # For the RSI function

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate RSI for Volume
rsi_period <- 14
Stock$RSI <- RSI(Stock$AAPL.Volume, n = rsi_period)

# Define the index for annotations
annotation_index <- index(Stock)[30]

# Create the RSI chart with annotations
rsi_chart <- ggplot(Stock, aes(x = index(Stock), y = RSI)) +
  geom_line(color = 'red') +
  geom_hline(yintercept = 70, linetype = "dashed", color = "blue") +
  geom_hline(yintercept = 30, linetype = "dashed", color = "blue") +
  annotate("text", x = annotation_index, y = 70, label = "Overbought", size = 5, color = "blue") +
  annotate("text", x = annotation_index, y = 30, label = "Oversold", size = 5, color = "blue") +
  geom_ribbon(aes(ymin = 30, ymax = 70), fill = '#adccff', alpha = 0.3) +
  labs(title = "Volume RSI",
       x = "Date",
       y = "RSI")

# Create the Closing Price chart
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Arrange charts using grid
grid.arrange(closing_price_chart, rsi_chart, ncol = 1)
