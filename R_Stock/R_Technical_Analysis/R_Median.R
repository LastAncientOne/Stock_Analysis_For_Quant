library(ggplot2)
library(gridExtra)
library(quantmod)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Median Indicator
Stock$Median <- rollapply(Stock$AAPL.Close, width = 20, FUN = median, fill = NA, align = "right")

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for Median Indicator
median_chart <- ggplot(Stock, aes(x = index(Stock), y = Median)) +
  geom_line(color = 'Blue') +
  labs(title = "Median Indicator",
       x = "Date",
       y = "Median") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, median_chart, ncol = 1)
