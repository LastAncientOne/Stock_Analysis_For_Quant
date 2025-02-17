# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(TTR)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Define the period for volatility calculation
n <- 20  # You can change this to the desired period

# Calculate daily returns
daily_returns <- diff(log(Cl(Stock)))  # log returns

# Calculate rolling standard deviation (volatility)
volatility <- runSD(daily_returns, n = n)

# Create data frames for plotting
price_df <- data.frame(Date = index(Stock), Close = as.numeric(Cl(Stock)))
volatility_df <- data.frame(Date = index(volatility), Volatility = as.numeric(volatility))

# Plot the closing price
plot_close <- ggplot(price_df, aes(x = Date, y = Close)) +
  geom_line(color = 'blue') +
  labs(title = 'Closing Price of AAPL Stock', x = 'Date', y = 'Close') +
  theme_minimal()

# Plot the volatility
plot_volatility <- ggplot(volatility_df, aes(x = Date, y = Volatility)) +
  geom_line(color = 'red') +
  labs(title = 'Volatility of AAPL Stock (20-day rolling)', x = 'Date', y = 'Volatility') +
  theme_minimal()

# Arrange the plots in a single layout (top for close price, bottom for volatility)
grid.arrange(plot_close, plot_volatility, ncol = 1, heights = c(2, 1))