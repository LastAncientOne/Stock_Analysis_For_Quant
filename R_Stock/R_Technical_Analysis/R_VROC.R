library(quantmod)
library(ggplot2)
library(gridExtra)
library(TTR)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Volume Rate of Change (VROC) - default 14-period
Stock$VROC <- ROC(Stock$AAPL.Volume, n = 14, type = "continuous") * 100  # Multiply by 100 for percentage

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Create a ggplot chart for VROC
vroc_chart <- ggplot(Stock, aes(x = index(Stock), y = VROC)) +
  geom_line(color = "red") +
  labs(title = "Volume Rate of Change (VROC)",
       x = "Date",
       y = "VROC (%)") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, vroc_chart, ncol = 1)