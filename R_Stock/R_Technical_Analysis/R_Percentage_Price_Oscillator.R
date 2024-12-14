# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate the 12-day and 26-day EMAs
ema_12 <- EMA(Cl(Stock), n = 12)
ema_26 <- EMA(Cl(Stock), n = 26)

# Calculate PPO
ppo <- ((ema_12 - ema_26) / ema_26) * 100

# Calculate the Signal Line (9-day EMA of PPO)
signal_line <- EMA(ppo, n = 9)

# Calculate the PPO Histogram
ppo_histogram <- ppo - signal_line

# Create the stock price plot
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +  # Closing price
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black"))

# Create the PPO plot
ppo_plot <- ggplot() +
  geom_line(aes(x = index(Stock), y = ppo, color = "PPO")) +  # PPO
  geom_line(aes(x = index(Stock), y = signal_line, color = "Signal Line")) +  # Signal Line
  geom_bar(aes(x = index(Stock), y = ppo_histogram), stat = "identity", fill = "lightblue", alpha = 0.6) +  # PPO Histogram
  labs(title = "Percentage Price Oscillator (PPO)",
       x = "Date",
       y = "PPO (%)") +
  theme_minimal() +
  scale_color_manual(values = c("PPO" = "blue", "Signal Line" = "red"))

# Arrange the two plots vertically
grid.arrange(price_plot, ppo_plot, ncol = 1)