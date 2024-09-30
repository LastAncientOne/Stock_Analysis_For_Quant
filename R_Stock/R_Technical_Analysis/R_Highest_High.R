# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate the Highest High with a moving window of n periods
n <- 20  # choose the number of periods for the moving average
Stock$Highest_High <- rollapply(Stock$AAPL.High, width = n, FUN = max, align = 'right', fill = NA)

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for the Highest High
highest_high_chart <- ggplot(Stock, aes(x = index(Stock), y = Highest_High)) +
  geom_line(color = 'red') +
  labs(title = "Highest High (Over 20 Periods)",
       x = "Date",
       y = "Highest High") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, highest_high_chart, ncol = 1)