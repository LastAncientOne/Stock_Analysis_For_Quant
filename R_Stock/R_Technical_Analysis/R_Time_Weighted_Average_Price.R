# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate the Typical Price (TP)
Stock$TP <- (Hi(Stock) + Lo(Stock) + Cl(Stock) + Op(Stock)) / 4

# Calculate the Time Weighted Average Price (TWAP) over 'n' periods
n <- 10  # You can change this to any number of periods
Stock$TWAP <- rollapply(Stock$TP, n, mean, fill = NA)

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for the Time Weighted Average Price (TWAP)
twap_chart <- ggplot(Stock, aes(x = index(Stock), y = TWAP)) +
  geom_line(color = 'blue') +
  labs(title = "Time Weighted Average Price (TWAP)",
       x = "Date",
       y = "TWAP") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, twap_chart, ncol = 1)