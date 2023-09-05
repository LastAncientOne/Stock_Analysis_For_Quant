# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Accumulation Distribution Line (ADL)
Stock$ADL <- cumsum((Stock$AAPL.Close - Stock$AAPL.Low) - (Stock$AAPL.High - Stock$AAPL.Close)) * Stock$AAPL.Volume

# Create separate charts for Closing Price and ADL
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = Stock + " Closing Price",
       x = "Date",
       y = "Price")

adl_chart <- ggplot(Stock, aes(x = index(Stock), y = ADL)) +
  geom_line(color='blue') +
  labs(title = "Accumulation Distribution Line (ADL)",
       x = "Date",
       y = "ADL")

# Arrange charts using grid
grid.arrange(closing_price_chart, adl_chart, ncol = 1)
