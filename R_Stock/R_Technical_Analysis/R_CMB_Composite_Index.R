# Load required libraries
library(quantmod)
library(TTR)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate the 14-period RSI
RSI_14 <- RSI(Cl(Stock), n = 14)

# Calculate RSI Chg (9-period ROC of 14-period RSI)
RSI_Chg <- ROC(RSI_14, n = 9) * 100

# Calculate RSI Mom (3-period SMA of 3-period RSI)
RSI_3 <- SMA(RSI_14, n = 3)
RSI_Mom <- SMA(RSI_3, n = 3)

# Composite Index Line
Composite_Index <- RSI_Chg + RSI_Mom

# Fast SMA Line (13-period SMA of Composite Index Line)
Fast_SMA <- SMA(Composite_Index, n = 13)

# Slow SMA Line (33-period SMA of Composite Index Line)
Slow_SMA <- SMA(Composite_Index, n = 33)

# Create the stock price plot
price_plot <- ggplot(data = fortify.zoo(Stock), aes(x = Index)) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black"))

# Create the Composite Index plot
composite_plot <- ggplot() +
  geom_line(data = fortify.zoo(Composite_Index), aes(x = Index, y = Composite_Index, color = "Composite Index")) +
  geom_line(data = fortify.zoo(Fast_SMA), aes(x = Index, y = Fast_SMA, color = "Fast SMA")) +
  geom_line(data = fortify.zoo(Slow_SMA), aes(x = Index, y = Slow_SMA, color = "Slow SMA")) +
  labs(title = "CMB Composite Index",
       x = "Date",
       y = "Index Value") +
  theme_minimal() +
  scale_color_manual(values = c("Composite Index" = "blue", "Fast SMA" = "red", "Slow SMA" = "green"))

# Arrange the plots vertically
grid.arrange(price_plot, composite_plot, ncol = 1)