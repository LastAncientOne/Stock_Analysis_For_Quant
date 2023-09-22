# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Arms Ease of Movement (EMV)
Stock$EMV <- ((Stock$AAPL.High + Stock$AAPL.Low) / 2 - lag(Stock$AAPL.High + lag(Stock$AAPL.Low)) / 2) / (Stock$AAPL.Volume / 1000)

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for EMV
emv_chart <- ggplot(Stock, aes(x = index(Stock), y = EMV)) +
  geom_line(color = 'blue') +
  labs(title = "Arms Ease of Movement (EMV)",
       x = "Date",
       y = "EMV") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, emv_chart, ncol = 1)

