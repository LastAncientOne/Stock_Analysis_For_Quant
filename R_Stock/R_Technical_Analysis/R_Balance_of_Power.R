# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Balance of Power (BOP)
Stock$BOP <- (Stock$AAPL.Close - (Stock$AAPL.Open + Stock$AAPL.Low + Stock$AAPL.High) / 3) / ((Stock$AAPL.High - Stock$AAPL.Low) / 3) * Stock$AAPL.Volume

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = Stock + " Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for BOP
bop_chart <- ggplot(Stock, aes(x = index(Stock), y = BOP)) +
  geom_line(color = 'red') +
  labs(title = "Balance of Power (BOP)",
       x = "Date",
       y = "BOP") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, bop_chart, ncol = 1)
