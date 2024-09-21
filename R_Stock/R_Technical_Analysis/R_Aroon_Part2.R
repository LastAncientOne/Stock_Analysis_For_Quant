# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(TTR)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Define window period for Aroon
n <- 25

# Calculate Days since last High and Low using a rolling window
Stock$DaysSinceLastHigh <- rollapply(Stock$AAPL.High, width = n, FUN = function(x) n - which.max(x) + 1, fill = NA, align = "right")
Stock$DaysSinceLastLow <- rollapply(Stock$AAPL.Low, width = n, FUN = function(x) n - which.min(x) + 1, fill = NA, align = "right")

# Calculate Aroon Up and Aroon Down
Stock$AroonUp <- ((n - Stock$DaysSinceLastHigh) / n) * 100
Stock$AroonDown <- ((n - Stock$DaysSinceLastLow) / n) * 100

# Remove intermediate columns
Stock <- Stock[, !names(Stock) %in% c('DaysSinceLastHigh', 'DaysSinceLastLow')]

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Create a ggplot chart for Aroon Up
aroon_up_chart <- ggplot(Stock, aes(x = index(Stock), y = AroonUp)) +
  geom_line(color = "blue") +
  labs(title = "Aroon Up (25-period)",
       x = "Date",
       y = "Aroon Up") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Create a ggplot chart for Aroon Down
aroon_down_chart <- ggplot(Stock, aes(x = index(Stock), y = AroonDown)) +
  geom_line(color = "red") +
  labs(title = "Aroon Down (25-period)",
       x = "Date",
       y = "Aroon Down") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, aroon_up_chart, aroon_down_chart, ncol = 1)
