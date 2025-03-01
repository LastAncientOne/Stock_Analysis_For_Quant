# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(TTR)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Define the number of days (n) for calculating momentum
n_days <- 10

# Calculate momentum: Closing Price [today] - Closing Price [n days ago]
momentum <- Cl(Stock) - lag(Cl(Stock), n = n_days)

# Create a data frame for plotting momentum
momentum_data <- data.frame(Date = index(Stock), Momentum = as.numeric(momentum))

# Create a data frame for plotting closing price
closing_data <- data.frame(Date = index(Stock), ClosingPrice = as.numeric(Cl(Stock)))

# Plot the closing price
closing_plot <- ggplot(closing_data, aes(x = Date, y = ClosingPrice)) +
  geom_line(color = 'blue') +
  ggtitle('AAPL Closing Price') +
  xlab('Date') +
  ylab('Closing Price') +
  theme_minimal()

# Plot the momentum
momentum_plot <- ggplot(momentum_data, aes(x = Date, y = Momentum)) +
  geom_line(color = 'red') +
  ggtitle('Momentum of AAPL Stock') +
  xlab('Date') +
  ylab('Momentum') +
  theme_minimal()

# Arrange both plots in one window (top for closing price, bottom for momentum)
grid.arrange(closing_plot, momentum_plot, ncol = 1)