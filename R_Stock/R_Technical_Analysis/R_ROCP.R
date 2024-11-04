library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate the Typical Price (TP)
Stock$TP <- (Hi(Stock) + Lo(Stock) + Cl(Stock)) / 3

# Set the number of periods for ROCP calculation
n <- 20  # choose the number of periods

# Calculate the Rate of Change Percentage (ROCP)
Stock$ROCP <- (Stock$AAPL.Close / lag(Stock$AAPL.Close, n) - 1) * 100

# Remove unnecessary columns
Stock$TP <- NULL  # We can drop TP as requested

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for the Rate of Change Percentage (ROCP)
rocp_chart <- ggplot(Stock, aes(x = index(Stock), y = ROCP)) +
  geom_line(color = 'blue') +
  labs(title = "Rate of Change Percentage (ROCP)",
       x = "Date",
       y = "ROCP (%)") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, rocp_chart, ncol = 1)