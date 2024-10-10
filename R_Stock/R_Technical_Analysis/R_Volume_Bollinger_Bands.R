# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Bollinger Bands based on volume
n <- 20  # Number of periods
k <- 2   # Number of standard deviations

Stock$SMA <- SMA(Vo(Stock), n)  # SMA on volume
Stock$SD <- k * runSD(Vo(Stock), n)  # SD on volume
Stock$UpperBand <- Stock$SMA + Stock$SD
Stock$LowerBand <- Stock$SMA - Stock$SD

# Create the stock price plot
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +  # Closing price
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black"))

# Create the volume Bollinger Bands plot
volume_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Vo(Stock), color = "Volume")) +  # Volume
  geom_line(aes(y = SMA, color = "SMA")) +  # SMA of volume
  geom_line(aes(y = UpperBand, color = "Upper Band"), linetype = "dashed") +
  geom_line(aes(y = LowerBand, color = "Lower Band"), linetype = "dashed") +
  labs(title = "Volume Bollinger Bands for AAPL",
       x = "Date",
       y = "Volume") +
  theme_minimal() +
  scale_color_manual(values = c("Volume" = "black", "SMA" = "blue", 
                                "Upper Band" = "green", "Lower Band" = "red"))

# Arrange the two plots vertically
grid.arrange(price_plot, volume_plot, ncol = 1)
