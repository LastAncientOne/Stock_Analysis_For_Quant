# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate TEMA
n <- 20  # You can choose the period for EMA here
EMA1 <- EMA(Cl(Stock), n = n)            # First EMA of close price
EMA2 <- EMA(EMA1, n = n)                 # EMA of EMA1
EMA3 <- EMA(EMA2, n = n)                 # EMA of EMA2
TEMA <- (3 * EMA1) - (3 * EMA2) + EMA3   # Triple Exponential Moving Average

# Append TEMA to the stock data
Stock$TEMA <- TEMA

# Create the stock price plot with TEMA
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +  # Closing price
  geom_line(aes(y = TEMA, color = "TEMA")) +             # TEMA line
  labs(title = "AAPL Stock Price with TEMA",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black", "TEMA" = "blue"))

# Calculate Volume Bollinger Bands
volume_n <- 20  # SMA period for volume
Stock$SMA <- SMA(Vo(Stock), n = volume_n)                    # SMA of volume
Stock$UpperBand <- Stock$SMA + 2 * runSD(Vo(Stock), n = volume_n)  # Upper Bollinger Band
Stock$LowerBand <- Stock$SMA - 2 * runSD(Vo(Stock), n = volume_n)  # Lower Bollinger Band

# Create the volume Bollinger Bands plot
volume_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Vo(Stock), color = "Volume")) +        # Volume
  geom_line(aes(y = SMA, color = "SMA")) +                 # SMA of volume
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