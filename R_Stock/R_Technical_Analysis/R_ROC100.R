library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate the Rate of Change (ROC100)
n <- 12  # choose the number of periods for the ROC calculation
Stock$ROC100 <- (Stock$AAPL.Adjusted / lag(Stock$AAPL.Adjusted, n)) * 100 - 100  # ROC100 calculation

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for the Rate of Change (ROC100)
roc_chart <- ggplot(Stock, aes(x = index(Stock), y = ROC100)) +
  geom_line(color = 'blue') +
  geom_hline(yintercept = 0, color = 'red', linetype = "dashed") +  # Add line at 0
  labs(title = "Rate of Change (ROC100)",
       x = "Date",
       y = "ROC100 (%)") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, roc_chart, ncol = 1)