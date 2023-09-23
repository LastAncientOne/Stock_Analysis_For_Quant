# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Accumulation/Distribution Line (ADL)
Stock$ADL <- cumsum(((Stock$AAPL.Close - Stock$AAPL.Low) - (Stock$AAPL.High - Stock$AAPL.Close)) / (Stock$AAPL.High - Stock$AAPL.Low) * Stock$AAPL.Volume)

# Calculate the 3-day and 10-day exponential moving averages (EMAs) of ADL
Stock$EMA3 <- EMA(Stock$ADL, n = 3)
Stock$EMA10 <- EMA(Stock$ADL, n = 10)

# Calculate the Chaikin Oscillator as the difference between the 3-day and 10-day EMAs
Stock$Chaikin_Oscillator <- Stock$EMA3 - Stock$EMA10

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = Stock + " Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for Chaikin Oscillator
chaikin_chart <- ggplot(Stock, aes(x = index(Stock), y = Chaikin_Oscillator)) +
  geom_line(color = 'red') +
  labs(title = "Chaikin Oscillator",
       x = "Date",
       y = "Chaikin Oscillator") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, chaikin_chart, ncol = 1)

