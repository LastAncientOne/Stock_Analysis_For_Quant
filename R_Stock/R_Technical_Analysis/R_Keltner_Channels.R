# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(TTR)  # For ATR calculation

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Keltner Channels (KC)
n <- 20  # Lookback period
multiplier <- 2  # ATR multiplier

ema <- EMA(Cl(Stock), n = n)  # 20-day EMA
atr <- ATR(HLC(Stock), n = n)  # Average True Range

Stock$UpperKC <- ema + (multiplier * atr$atr)
Stock$LowerKC <- ema - (multiplier * atr$atr)
Stock$KC_PercentB <- (Cl(Stock) - Stock$LowerKC) / (Stock$UpperKC - Stock$LowerKC)

# Create the stock price plot with Keltner Channels
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +  # Closing price
  geom_line(aes(y = Stock$UpperKC, color = "Upper KC"), linetype = "dashed") +
  geom_line(aes(y = Stock$LowerKC, color = "Lower KC"), linetype = "dashed") +
  labs(title = "AAPL Stock Price with Keltner Channels",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black", "Upper KC" = "red", "Lower KC" = "blue")) +
  theme(legend.title = element_blank())

# Plot Keltner %B (similar to Bollinger %B)
kcB_plot <- ggplot(Stock, aes(x = index(Stock), y = KC_PercentB)) +
  geom_line(color = "purple") +
  labs(title = "AAPL Keltner Channels",
       x = "Date",
       y = "Keltner Channels") +
  theme_minimal()

# Arrange the two plots vertically
grid.arrange(price_plot, kcB_plot, ncol = 1)

