# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(zoo)  # For rollapply

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate daily returns
Stock$Return <- dailyReturn(Stock$AAPL.Adjusted, type = 'log')

# Calculate the Geometric Return Indicator with a moving window of n periods
n <- 20  # choose the number of periods for the moving average
geometric_return <- rollapply(Stock$Return, width = n, FUN = function(x) {
  exp(sum(x)) - 1
}, align = 'right', fill = NA)

# Add the geometric return to the Stock data
Stock$Geometric_Return <- geometric_return

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for the Geometric Return
geometric_return_chart <- ggplot(Stock, aes(x = index(Stock), y = Geometric_Return)) +
  geom_line(color = 'blue') +
  labs(title = "Geometric Return (Over 20 Periods)",
       x = "Date",
       y = "Geometric Return") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, geometric_return_chart, ncol = 1)
