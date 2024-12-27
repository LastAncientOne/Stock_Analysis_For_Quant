# Load required libraries
library(quantmod)
library(TTR)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Parameters for Chande Kroll Stop
p <- 10  # Lookback period for preliminary stops
q <- 5   # Lookback period for final stops
x <- 1.5 # Multiplier for ATR

# Calculate Average True Range (ATR)
atr <- ATR(HLC(Stock), n = p)[, "atr"]

# Preliminary high and low stops
preliminary_high_stop <- runMax(Hi(Stock), n = p) - x * atr
preliminary_low_stop <- runMin(Lo(Stock), n = p) + x * atr

# Final Chande Kroll Stop calculations
short_stop <- runMax(preliminary_high_stop, n = q)
long_stop <- runMin(preliminary_low_stop, n = q)

# Combine stops with the stock data
Stock <- cbind(Stock, preliminary_high_stop, preliminary_low_stop, short_stop, long_stop)

# Calculate Weighted Close
Weighted_Close <- (Hi(Stock) + Lo(Stock) + (Cl(Stock) * 2)) / 4
Stock <- cbind(Stock, Weighted_Close)

# Create the stock price plot with Chande Kroll Stop levels
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +  # Close price
  geom_line(aes(y = Weighted_Close, color = "Weighted Close")) +  # Weighted close
  geom_line(aes(y = short_stop, color = "Short Stop")) +  # Short stop level
  geom_line(aes(y = long_stop, color = "Long Stop")) +  # Long stop level
  labs(title = "AAPL Stock Price with Chande Kroll Stop",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black", 
                                "Weighted Close" = "blue",
                                "Short Stop" = "red", 
                                "Long Stop" = "green")) +
  theme(legend.title = element_blank())

# Plot the final chart
grid.arrange(price_plot, ncol = 1)