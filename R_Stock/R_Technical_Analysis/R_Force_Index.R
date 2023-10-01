# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Force Index (FI)
Stock$FI <- (Stock$AAPL.Close - lag(Stock$AAPL.Close)) * Stock$AAPL.Volume

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for Force Index (FI)
fi_chart <- ggplot(Stock, aes(x = index(Stock), y = FI)) +
  geom_line(color = 'blue') +
  labs(title = "Force Index (FI)",
       x = "Date",
       y = "FI") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, fi_chart, ncol = 1)
