# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Fast Stochastic
stochastic_period <- 14
Stock$High <- Hi(Stock)
Stock$Low <- Lo(Stock)
Stock$FastK <- 100 * (Stock$AAPL.Close - rollapply(Stock$Low, stochastic_period, min)) / (rollapply(Stock$High, stochastic_period, max) - rollapply(Stock$Low, stochastic_period, min))
Stock$FastD <- SMA(Stock$FastK, n = 3)  # You can adjust the SMA period as needed

# Create separate charts for Closing Price and Fast Stochastic
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

stochastic_chart <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = FastK), color = 'blue', linetype = 'solid', size = 1) +
  geom_line(aes(y = FastD), color = 'red', linetype = 'dashed', size = 1) +
  labs(title = "Fast Stochastic",
       x = "Date",
       y = "Value") +
  scale_y_continuous(limits = c(0, 100))  # Ensure y-axis range is between 0 and 100

# Arrange charts using grid
grid.arrange(closing_price_chart, stochastic_chart, ncol = 1)

