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

# Combine Gator Upper and Lower into one chart
gator_combined_chart <- ggplot(Stock, aes(x = index(Stock))) +
  geom_bar(aes(y = GatorUpper), stat = "identity", fill = "green") +    # Upper Gator
  geom_bar(aes(y = -GatorLower), stat = "identity", fill = "red") +     # Lower Gator (negative)
  labs(title = "Gator Oscillator (Upper: Jaw - Teeth, Lower: Teeth - Lips)",
       x = "Date",
       y = "Gator Oscillator") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, gator_combined_chart, ncol = 1)
