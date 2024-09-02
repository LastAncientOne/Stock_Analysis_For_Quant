library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate the maximum rolling indicator (you can choose a window size, e.g., 20 days)
Stock$max <- rollapply(Stock$AAPL.Close, width = 20, FUN = max, fill = NA, align = 'right')

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Create a ggplot chart for Maximum Indicator
max_chart <- ggplot(Stock, aes(x = index(Stock), y = max)) +
  geom_line(color = 'blue') +
  labs(title = "Maximum Indicator (20-day)",
       x = "Date",
       y = "Maximum Price") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, max_chart, ncol = 1)