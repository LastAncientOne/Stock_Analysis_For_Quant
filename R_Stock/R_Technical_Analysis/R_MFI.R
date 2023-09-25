# Load necessary libraries
library(quantmod)
library(ggplot2)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Money Flow Index (MFI)
mfi_period <- 14
typical_price <- (Stock$AAPL.High + Stock$AAPL.Low + Stock$AAPL.Close) / 3
raw_money_flow <- typical_price * Stock$AAPL.Volume
positive_flow <- ifelse(typical_price > lag(typical_price),
                        raw_money_flow, 0)
negative_flow <- ifelse(typical_price < lag(typical_price),
                        raw_money_flow, 0)
positive_money_flow <- xts(NA, order.by=index(Stock))
negative_money_flow <- xts(NA, order.by=index(Stock))
for (i in (mfi_period+1):NROW(Stock)) {
  positive_money_flow[i] <- sum(positive_flow[(i-mfi_period):i], na.rm = TRUE)
  negative_money_flow[i] <- sum(negative_flow[(i-mfi_period):i], na.rm = TRUE)
}
money_ratio <- positive_money_flow / negative_money_flow
mfi <- 100 - (100 / (1 + money_ratio))
Stock$MFI <- mfi

# Create separate charts for Closing Price and MFI
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

mfi_chart <- ggplot(Stock, aes(x = index(Stock), y = MFI)) +
  geom_line(color='blue') +
  labs(title = "Money Flow Index (MFI)",
       x = "Date",
       y = "MFI")

# Arrange charts using grid
library(gridExtra)
grid.arrange(closing_price_chart, mfi_chart, ncol = 1)
