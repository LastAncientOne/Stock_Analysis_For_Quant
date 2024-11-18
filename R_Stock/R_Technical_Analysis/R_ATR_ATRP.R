# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(TTR)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate ATR (14-day) using the TTR package
atr_values <- ATR(HLC(Stock), n = 14)
atr <- atr_values[, "atr"]

# Calculate ATR percentage (ATRP)
atrp <- (atr / Cl(Stock)) * 100

# Add ATR and ATRP to the Stock data
Stock$ATR <- atr
Stock$ATRP <- atrp

# Create the stock price plot
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +  # Closing price
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black"))

# Create the ATR plot
atr_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = ATR, color = "ATR")) +  # ATR values
  labs(title = "AAPL ATR (14-day)",
       x = "Date",
       y = "ATR") +
  theme_minimal() +
  scale_color_manual(values = c("ATR" = "blue"))

# Create the ATRP plot
atrp_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = ATRP, color = "ATRP (%)")) +  # ATRP values
  labs(title = "AAPL ATR Percentage (ATRP)",
       x = "Date",
       y = "ATRP (%)") +
  theme_minimal() +
  scale_color_manual(values = c("ATRP (%)" = "red"))

# Arrange the three plots vertically
grid.arrange(price_plot, atr_plot, atrp_plot, ncol = 1)