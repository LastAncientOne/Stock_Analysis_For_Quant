# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate ATR (Average True Range)
atrs <- ATR(HLC(Stock), n = 14)
Stock$ATR <- atrs$atr

# Define ATR multiple for stop calculation
atr_multiplier <- 3

# Initialize Volatility Stop
Stock$VolStop <- NA
Stock$Trend <- NA

# Compute Volatility Stop
for (i in 15:nrow(Stock)) {
  if (Cl(Stock)[i] > Stock$VolStop[i-1] || is.na(Stock$VolStop[i-1])) {
    Stock$VolStop[i] <- max(Stock$VolStop[i-1], Cl(Stock)[i] - atr_multiplier * Stock$ATR[i], na.rm = TRUE)
    Stock$Trend[i] <- 1  # Uptrend
  } else {
    Stock$VolStop[i] <- min(Stock$VolStop[i-1], Cl(Stock)[i] + atr_multiplier * Stock$ATR[i], na.rm = TRUE)
    Stock$Trend[i] <- -1 # Downtrend
  }
}

# Create stock price plot with Volatility Stops
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +
  geom_line(aes(y = Stock$VolStop, color = "Volatility Stop"), linetype = "dashed") +
  labs(title = "AAPL Stock Price with Volatility Stops",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black", "Volatility Stop" = "red")) +
  theme(legend.title = element_blank())

# Plot ATR values
atr_plot <- ggplot(Stock, aes(x = index(Stock), y = Stock$ATR)) +
  geom_line(color = "blue") +
  labs(title = "AAPL ATR (14-day)",
       x = "Date",
       y = "ATR") +
  theme_minimal()

# Arrange the two plots vertically
grid.arrange(price_plot, atr_plot, ncol = 1)