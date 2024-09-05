library(ggplot2)
library(gridExtra)
library(quantmod)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate High Minus Low (HML)
Stock$HML <- Stock$AAPL.High - Stock$AAPL.Low

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for High Minus Low (HML)
hml_chart <- ggplot(Stock, aes(x = index(Stock), y = HML)) +
  geom_line(color = 'blue') +
  labs(title = "High Minus Low",
       x = "Date",
       y = "HML") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, hml_chart, ncol = 1)