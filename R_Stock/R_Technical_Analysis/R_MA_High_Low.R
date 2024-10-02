# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(zoo)  # For rollapply function

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Define the number of periods for the moving averages
n <- 10
m <- 10

# Calculate the Moving Average High and Low with a rolling window
Stock$MA_High <- rollapply(Stock$AAPL.High, width = n, FUN = mean, align = 'right', fill = NA)
Stock$MA_Low <- rollapply(Stock$AAPL.Low, width = m, FUN = mean, align = 'right', fill = NA)

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for the Moving Average High
ma_high_chart <- ggplot(Stock, aes(x = index(Stock), y = MA_High)) +
  geom_line(color = 'red') +
  labs(title = "Moving Average High (Over 10 Periods)",
       x = "Date",
       y = "Moving Average High") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Create a ggplot chart for the Moving Average Low
ma_low_chart <- ggplot(Stock, aes(x = index(Stock), y = MA_Low)) +
  geom_line(color = 'green') +
  labs(title = "Moving Average Low (Over 10 Periods)",
       x = "Date",
       y = "Moving Average Low") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, ma_high_chart, ma_low_chart, ncol = 1)