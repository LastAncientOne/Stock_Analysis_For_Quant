# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Accumulation/Distribution Line (ADL)
Stock$ADL <- cumsum(((Stock$AAPL.Close - Stock$AAPL.Low) - (Stock$AAPL.High - Stock$AAPL.Close)) / (Stock$AAPL.High - Stock$AAPL.Low) * Stock$AAPL.Volume)

# Calculate Double Exponential Moving Average (DEMA) for ADL
period <- 14  # You can adjust this period as needed
EMA1 <- EMA(Stock$ADL, n = period)
EMA2 <- EMA(EMA1, n = period)
DEMA <- 2 * EMA1 - EMA2

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = Stock + " Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for DEMA
dema_chart <- ggplot() +
  geom_line(data = data.frame(Date = index(Stock), DEMA = DEMA), aes(x = Date, y = DEMA), color = 'red') +
  labs(title = "Double Exponential Moving Average (DEMA) of ADL",
       x = "Date",
       y = "DEMA") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, dema_chart, ncol = 1)
