# Load necessary libraries
library(quantmod)
library(TTR)  # for ATR and SMA

# Download stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate ATR
Stock$ATR <- ATR(HLC(Stock), n = 22)$atr

# Calculate Chandelier Exit
Stock$High_22 <- runMax(Cl(Stock), n = 22)
Stock$Low_22 <- runMin(Cl(Stock), n = 22)

# Calculate Long and Short Chandelier Exits
Stock$CH_Long <- Stock$High_22 - (Stock$ATR * 3)
Stock$CH_Short <- Stock$Low_22 + (Stock$ATR * 3)

# Create a grid chart
chart <- ggplot(data = Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Price"), size = 1) +
  geom_line(aes(y = Stock$CH_Long, color = "Chandelier Long"), size = 0.8, linetype = "dashed") +
  geom_line(aes(y = Stock$CH_Short, color = "Chandelier Short"), size = 0.8, linetype = "dashed") +
  labs(title = paste("AAPL Stock Price with Chandelier Exits"),
       x = "Date",
       y = "Price") +
  scale_color_manual(values = c("Price" = "blue", "Chandelier Long" = "orange", "Chandelier Short" = "red")) +
  theme_minimal()

print(chart)