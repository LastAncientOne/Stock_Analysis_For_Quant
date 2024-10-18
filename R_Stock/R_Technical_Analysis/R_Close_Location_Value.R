# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(TTR)  # for technical indicators

# Get stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Set the shift period
n <- 10

# Calculate the Close Location Value (CLV)
Stock$CLV <- ((Cl(Stock) - Lo(Stock)) - (Hi(Stock) - Cl(Stock))) / (Hi(Stock) - Lo(Stock))
Stock$CLV <- shift(Stock$CLV, n)

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = Cl(Stock))) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for the Close Location Value (CLV)
clv_chart <- ggplot(Stock, aes(x = index(Stock), y = CLV)) +
  geom_line(color = 'blue') +
  labs(title = "Close Location Value (CLV)",
       x = "Date",
       y = "CLV") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, clv_chart, ncol = 1)