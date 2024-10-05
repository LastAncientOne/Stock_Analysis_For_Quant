# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(zoo)  # For rollapply function

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate daily returns
Stock$Return <- dailyReturn(Stock$AAPL.Adjusted)

# Define the window period
n <- 20

# Calculate standard deviation of returns using rolling window
Stock$STD <- rollapply(Stock$Return, width = n, FUN = sd, align = 'right', fill = NA)

# Convert standard deviation to annualized historical volatility
# 252 trading days in a year
Stock$HV <- 100 * (Stock$STD * sqrt(252))

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Adjusted)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for Historical Volatility
historical_volatility_chart <- ggplot(Stock, aes(x = index(Stock), y = HV)) +
  geom_line(color = 'blue') +
  labs(title = "Historical Volatility (Annualized, Over 20 Periods)",
       x = "Date",
       y = "Historical Volatility (%)") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, historical_volatility_chart, ncol = 1)