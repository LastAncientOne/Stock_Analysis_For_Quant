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

# Create a data frame for plotting
momentum_data <- data.frame(Date = index(Stock), Momentum = as.numeric(momentum))

# Plot the momentum
ggplot(momentum_data, aes(x = Date, y = Momentum)) +
  geom_line(color = 'blue') +
  ggtitle('Momentum of AAPL Stock') +
  xlab('Date') +
  ylab('Momentum') +
  theme_minimal()