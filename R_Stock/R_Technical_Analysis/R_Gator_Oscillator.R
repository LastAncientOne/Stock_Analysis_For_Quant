library(quantmod)
library(ggplot2)
library(gridExtra)
library(TTR)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate the Alligator Indicator components: Jaw (13-period), Teeth (8-period), Lips (5-period)
Stock$Jaw <- SMA(Stock$AAPL.Close, n = 13)
Stock$Teeth <- SMA(Stock$AAPL.Close, n = 8)
Stock$Lips <- SMA(Stock$AAPL.Close, n = 5)

# Calculate the Gator Oscillator components
Stock$GatorUpper <- abs(Stock$Jaw - Stock$Teeth)  # Upper histogram: Jaw - Teeth
Stock$GatorLower <- abs(Stock$Teeth - Stock$Lips)  # Lower histogram: Teeth - Lips

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Create a ggplot chart for the Gator Oscillator Upper
gator_upper_chart <- ggplot(Stock, aes(x = index(Stock), y = GatorUpper)) +
  geom_bar(stat = "identity", fill = "green") +
  labs(title = "Gator Oscillator (Upper: Jaw - Teeth)",
       x = "Date",
       y = "Upper Oscillator") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Create a ggplot chart for the Gator Oscillator Lower
gator_lower_chart <- ggplot(Stock, aes(x = index(Stock), y = -GatorLower)) +  # Negative for lower part
  geom_bar(stat = "identity", fill = "red") +
  labs(title = "Gator Oscillator (Lower: Teeth - Lips)",
       x = "Date",
       y = "Lower Oscillator") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, gator_upper_chart, gator_lower_chart, ncol = 1)
