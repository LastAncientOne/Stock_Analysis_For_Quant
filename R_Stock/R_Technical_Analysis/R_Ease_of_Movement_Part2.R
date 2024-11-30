# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(TTR)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Distance Moved
distance_moved <- ((Hi(Stock) + Lo(Stock)) / 2) - lag((Hi(Stock) + Lo(Stock)) / 2)

# Calculate Box Ratio
box_ratio <- (Vo(Stock) / 100000000) / (Hi(Stock) - Lo(Stock))

# Calculate 1-Period EMV
emv_1_period <- distance_moved / box_ratio

# Calculate 14-Period EMV (Simple Moving Average of 1-Period EMV)
emv_14_period <- SMA(emv_1_period, n = 14)

# Add EMV to Stock data for plotting
Stock$EMV_14 <- emv_14_period

# Create the stock price plot
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black"))

# Create the 14-Period EMV plot
emv_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = EMV_14, color = "14-Period EMV")) +
  labs(title = "AAPL 14-Period Ease of Movement (EMV)",
       x = "Date",
       y = "EMV") +
  theme_minimal() +
  scale_color_manual(values = c("14-Period EMV" = "blue"))

# Arrange the two plots vertically
grid.arrange(price_plot, emv_plot, ncol = 1)