library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Heiken Ashi
HA_Close <- (Op(Stock) + Hi(Stock) + Lo(Stock) + Cl(Stock)) / 4
HA_Open <- (Op(Stock) + Cl(Stock)) / 2

for (i in 2:NROW(Stock)) {
  HA_Open[i] <- (HA_Open[i-1] + HA_Close[i-1]) / 2
}

HA_High <- pmax(HA_Open, HA_Close, Hi(Stock))
HA_Low <- pmin(HA_Open, HA_Close, Lo(Stock))

# Adding Heiken Ashi values to the Stock object
Stock$HA_Open <- HA_Open
Stock$HA_Close <- HA_Close
Stock$HA_High <- HA_High
Stock$HA_Low <- HA_Low

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for Heiken Ashi (HA_Close)
ha_chart <- ggplot(Stock, aes(x = index(Stock), y = HA_Close)) +
  geom_line(color = 'blue') +
  labs(title = "Heiken Ashi Closing Price",
       x = "Date",
       y = "HA_Close") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, ha_chart, ncol = 1)