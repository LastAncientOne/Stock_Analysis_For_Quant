library(quantmod)
library(ggplot2)
library(gridExtra)
library(TTR)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate the ATR (14-period default) and ATRP
Stock$ATR <- ATR(Stock[,c("AAPL.High", "AAPL.Low", "AAPL.Close")], n = 14)$atr
Stock$ATRP <- (Stock$ATR / Stock$AAPL.Close) * 100

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Create a ggplot chart for ATRP
atrp_chart <- ggplot(Stock, aes(x = index(Stock), y = ATRP)) +
  geom_line(color = "blue") +
  labs(title = "Average True Range Percent (ATRP)",
       x = "Date",
       y = "ATRP (%)") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, atrp_chart, ncol = 1)
