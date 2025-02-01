# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Arms Ease of Movement (EMV)
Stock$Midpoint <- (Stock$AAPL.High + Stock$AAPL.Low) / 2
Stock$Box_Ratio <- Stock$AAPL.Volume / (Stock$AAPL.High - Stock$AAPL.Low)
Stock$EMV <- Stock$Box_Ratio * Stock$Midpoint

# Plot Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = paste("AAPL Closing Price"),  # corrected title concatenation
       x = "Date",
       y = "Price")

# Plot Closing Price and EMV
emv_chart <- ggplot(Stock, aes(x = index(Stock), y = EMV)) +
  geom_line(color='blue') +
  labs(title = "Arms Ease of Movement (EMV)",
       x = "Date",
       y = "EMV")

# Arrange charts using grid
grid.arrange(closing_price_chart, emv_chart, ncol = 1)


