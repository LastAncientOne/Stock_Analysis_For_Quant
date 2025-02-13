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

# Calculate the moving standard deviation of closing prices
Stock$SD <- runSD(Cl(Stock), n)

# Calculate the moving average of closing prices
Stock$Avg <- SMA(Cl(Stock), n)

# Calculate volatility
Stock$Volatility <- Stock$SD / Stock$Avg

# Remove NA values
Stock <- na.omit(Stock)

# Plot the volatility indicator
p1 <- ggplot(data = data.frame(Date = index(Stock), Volatility = Stock$Volatility), aes(x = Date, y = Volatility)) +
  geom_line(color = 'blue') +
  ggtitle('Volatility Indicator for AAPL') +
  xlab('Date') +
  ylab('Volatility') +
  theme_minimal()

# Display the plot
print(p1)