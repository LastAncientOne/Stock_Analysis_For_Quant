# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate the Lowest Low with a moving window of n periods
n <- 20  # choose the number of periods for the moving average
Stock$Lowest_Low <- rollapply(Stock$AAPL.Low, width = n, FUN = min, align = 'right', fill = NA)

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for the Lowest Low
lowest_low_chart <- ggplot(Stock, aes(x = index(Stock), y = Lowest_Low)) +
  geom_line(color = 'blue') +
  labs(title = "Lowest Low (Over 20 Periods)",
       x = "Date",
       y = "Lowest Low") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, lowest_low_chart, ncol = 1)
