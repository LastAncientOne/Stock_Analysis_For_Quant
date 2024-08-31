# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate True Strength Index (TSI)
n1 <- 25  # EMA period for price changes
n2 <- 13  # EMA period for TSI
PriceChange <- Delt(Cl(Stock$AAPL.Close), k = n1)
E1 <- EMA(PriceChange, n = n1)
E2 <- EMA(E1, n = n1)
TSI <- EMA(E2, n = n2)

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for True Strength Index (TSI)
tsi_chart <- ggplot() +
  geom_line(data = data.frame(index = index(Stock), TSI = TSI), aes(x = index, y = TSI), color = 'blue') +
  labs(title = "True Strength Index (TSI)",
       x = "Date",
       y = "TSI") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, tsi_chart, ncol = 1)

