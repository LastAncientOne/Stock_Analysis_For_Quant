# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Accumulation/Distribution Line (ADL)
Stock$ADL <- cumsum(((Stock$AAPL.Close - Stock$AAPL.Low) - (Stock$AAPL.High - Stock$AAPL.Close)) / (Stock$AAPL.High - Stock$AAPL.Low) * Stock$AAPL.Volume)

# Calculate Balance of Power (BOP)
Stock$BOP <- (Stock$AAPL.Close - Stock$AAPL.Open) / (Stock$AAPL.High - Stock$AAPL.Low)

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = Stock + " Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for ADL
adl_chart <- ggplot(Stock, aes(x = index(Stock), y = ADL)) +
  geom_line(color = 'blue') +
  labs(title = "Accumulation/Distribution Line (ADL)",
       x = "Date",
       y = "ADL") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Create a ggplot chart for BOP
bop_chart <- ggplot(Stock, aes(x = index(Stock), y = BOP)) +
  geom_line(color = 'red') +
  labs(title = "Balance of Power (BOP)",
       x = "Date",
       y = "BOP") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, adl_chart, bop_chart, ncol = 1)
