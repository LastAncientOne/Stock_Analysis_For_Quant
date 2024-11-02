library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate the Return on Investment (ROI)
Stock$ROI <- (Cl(Stock) - Lag(Cl(Stock), k = 1)) / Lag(Cl(Stock), k = 1) * 100

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = Cl(Stock))) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for the Return on Investment (ROI)
roi_chart <- ggplot(Stock, aes(x = index(Stock), y = ROI)) +
  geom_line(color = 'blue') +
  labs(title = "Return on Investment (ROI)",
       x = "Date",
       y = "ROI (%)") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, roi_chart, ncol = 1)