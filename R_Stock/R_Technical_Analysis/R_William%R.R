# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate William %R
period <- 14  # You can adjust the period as needed
Stock$LowestLow <- runMin(Stock$AAPL.Low, n = period)
Stock$HighestHigh <- runMax(Stock$AAPL.High, n = period)
Stock$WilliamR <- -100 * ((Stock$HighestHigh - Stock$AAPL.Close) / (Stock$HighestHigh - Stock$LowestLow))

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = Stock + " Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for William %R
williamr_chart <- ggplot(Stock, aes(x = index(Stock), y = WilliamR)) +
  geom_line(color = 'red') +
  labs(title = "William %R",
       x = "Date",
       y = "William %R") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, williamr_chart, ncol = 1)
