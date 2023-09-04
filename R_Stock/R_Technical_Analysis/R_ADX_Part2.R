# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate ADX
adx_period <- 14
Stock$ADX <- ADX(HLC(Stock), n = adx_period)

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for ADX
adx_chart <- ggplot(Stock, aes(x = index(Stock), y = ADX)) +
  geom_line(color = 'green') +
  geom_hline(yintercept = 50, linetype = "dashed", color = "red") +
  geom_hline(yintercept = 20, linetype = "dashed", color = "blue") +
  labs(title = "Average Directional Index (ADX)",
       x = "Date",
       y = "ADX") +
  # Add text to the ADX chart
  annotate("text", x = index(Stock)[1], y = 50, label = "Strong Trend", size = 5, color = "black", hjust = 0, vjust =0.1) +
  annotate("text", x = index(Stock)[1], y = 20, label = "Weak Trend", size = 5, color = "black", hjust = 0, vjust=0.1) +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, adx_chart, ncol = 1)

