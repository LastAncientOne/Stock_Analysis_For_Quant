library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate the Minimum Indicator (rolling minimum over a window, e.g., 20 days)
Stock$min <- rollapply(Stock$AAPL.Close, width = 20, FUN = min, by = 1, fill = NA, align = "right")

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Create a ggplot chart for Minimum Indicator
min_chart <- ggplot(Stock, aes(x = index(Stock), y = min)) +
  geom_line(color = 'blue') +
  labs(title = "Minimum Indicator (20-day)",
       x = "Date",
       y = "Minimum Price") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, min_chart, ncol = 1)
