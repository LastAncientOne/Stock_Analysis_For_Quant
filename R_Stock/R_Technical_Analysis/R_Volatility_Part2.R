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

# Create a data frame for plotting
volatility_df <- data.frame(Date = index(volatility), Volatility = volatility)

# Plot the volatility
ggplot(volatility_df, aes(x = Date, y = Volatility)) +
  geom_line(color = 'blue') +
  labs(title = 'Volatility of AAPL Stock (20-day rolling)',
       x = 'Date', y = 'Volatility') +
  theme_minimal()