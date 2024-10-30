# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(TTR)  # for technical indicators

# Get stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate TRIX with n periods
n <- 15  # choose the number of periods for the TRIX calculation
Stock$TRIX <- TRIX(Cl(Stock), n = n)  # TRIX calculation using closing price

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for the TRIX
trix_chart <- ggplot(Stock, aes(x = index(Stock), y = TRIX)) +
  geom_line(color = 'blue') +
  labs(title = "TRIX",
       x = "Date",
       y = "TRIX") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, trix_chart, ncol = 1)