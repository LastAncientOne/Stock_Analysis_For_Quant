# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Choppiness Index
n <- 14
Stock$High_Max <- runMax(Stock$AAPL.High, n)
Stock$Low_Min <- runMin(Stock$AAPL.Low, n)
Stock$Range <- Stock$High_Max - Stock$Low_Min
Stock$Close_Min <- runMin(Stock$AAPL.Close, n)
Stock$CI <- log(Stock$Range / (Stock$High_Max + Stock$Low_Min) / 2) / log(n)

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for Choppiness Index
choppiness_index_chart <- ggplot(Stock, aes(x = index(Stock), y = CI)) +
  geom_line(color = 'blue') +
  labs(title = "Choppiness Index",
       x = "Date",
       y = "Choppiness Index") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, choppiness_index_chart, ncol = 1)
