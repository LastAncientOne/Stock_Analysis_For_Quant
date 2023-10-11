# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Accumulation/Distribution Line (ADL)
Stock$ADL <- cumsum(((Stock$AAPL.Close - Stock$AAPL.Low) - (Stock$AAPL.High - Stock$AAPL.Close)) / (Stock$AAPL.High - Stock$AAPL.Low) * Stock$AAPL.Volume)

# Function to calculate RSI
calculate_RSI <- function(data, period = 14) {
  delta <- data$AAPL.Close - lag(data$AAPL.Close)
  gain <- ifelse(delta > 0, delta, 0)
  loss <- ifelse(delta < 0, abs(delta), 0)
  avg_gain <- SMA(gain, n = period)
  avg_loss <- SMA(loss, n = period)
  rs <- avg_gain / avg_loss
  rsi <- 100 - (100 / (1 + rs))
  return(rsi)
}

# Calculate RSI
Stock$RSI <- calculate_RSI(Stock)

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for RSI
rsi_chart <- ggplot(Stock, aes(x = index(Stock), y = RSI)) +
  geom_line(color = 'blue') +
  labs(title = "Relative Strength Index (RSI)",
       x = "Date",
       y = "RSI") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Generate buy and sell signals based on overbought and oversold conditions
Stock$Buy_Signal <- ifelse(Stock$RSI < 30, 1, 0)  # Buy when RSI is below 30 (oversold)
Stock$Sell_Signal <- ifelse(Stock$RSI > 70, -1, 0)  # Sell when RSI is above 70 (overbought)

# Create a ggplot chart for Buy and Sell signals
signal_chart <- ggplot(Stock, aes(x = index(Stock))) +
  geom_point(aes(y = Buy_Signal, color = "Buy"), size = 2) +
  geom_point(aes(y = Sell_Signal, color = "Sell"), size = 2) +
  scale_color_manual(values = c("Buy" = "green", "Sell" = "red")) +
  labs(title = "Buy and Sell Signals based on RSI",
       x = "Date",
       y = "Signal") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, rsi_chart, signal_chart, ncol = 1)
