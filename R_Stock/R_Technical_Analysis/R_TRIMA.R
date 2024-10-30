# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate a simple moving average (SMA) for TRIMA
n <- 7  # window size for the moving average

# First step: calculate the first simple moving average (SMA)
Stock$SMA1 <- rollapply(Stock[, "AAPL.Adjusted"], width = n, FUN = mean, fill = NA, align = "right")

# Second step: apply another moving average on the first SMA to get the TRIMA
Stock$TRIMA <- rollapply(Stock$SMA1, width = n, FUN = mean, fill = NA, align = "right")

# Remove unnecessary columns
Stock$SMA1 <- NULL  # We can drop SMA1 as it's intermediate

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for the Triangular Moving Average (TRIMA)
trima_chart <- ggplot(Stock, aes(x = index(Stock), y = TRIMA)) +
  geom_line(color = 'blue') +
  labs(title = "Triangular Moving Average (TRIMA)",
       x = "Date",
       y = "TRIMA") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, trima_chart, ncol = 1)