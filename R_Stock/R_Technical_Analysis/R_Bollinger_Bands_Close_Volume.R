# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Convert to data.frame and include Date
Stock_df <- data.frame(Date = index(Stock), coredata(Stock))

# Calculate Bollinger Bands based on close price
n <- 20  # Number of periods
k <- 2   # Number of standard deviations

Stock_df$SMA_Close <- SMA(Cl(Stock), n)
Stock_df$SD_Close <- k * runSD(Cl(Stock), n)
Stock_df$UpperBand_Close <- Stock_df$SMA_Close + Stock_df$SD_Close
Stock_df$LowerBand_Close <- Stock_df$SMA_Close - Stock_df$SD_Close

# Calculate Bollinger Bands based on volume
Stock_df$SMA_Volume <- SMA(Vo(Stock), n)
Stock_df$SD_Volume <- k * runSD(Vo(Stock), n)
Stock_df$UpperBand_Volume <- Stock_df$SMA_Volume + Stock_df$SD_Volume
Stock_df$LowerBand_Volume <- Stock_df$SMA_Volume - Stock_df$SD_Volume

# Create the stock price plot
price_plot <- ggplot(Stock_df, aes(x = Date)) +
  geom_line(aes(y = Cl(Stock), color = "Close")) +
  geom_line(aes(y = SMA_Close, color = "SMA")) +
  geom_line(aes(y = UpperBand_Close, color = "Upper Band"), linetype = "dashed") +
  geom_line(aes(y = LowerBand_Close, color = "Lower Band"), linetype = "dashed") +
  labs(title = "Bollinger Bands for AAPL (Close Price)",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close" = "black", "SMA" = "blue", 
                                "Upper Band" = "green", "Lower Band" = "red"))

# Create the volume Bollinger Bands plot
volume_plot <- ggplot(Stock_df, aes(x = Date)) +
  geom_line(aes(y = Vo(Stock), color = "Volume")) +  # Volume
  geom_line(aes(y = SMA_Volume, color = "SMA")) +  # SMA of volume
  geom_line(aes(y = UpperBand_Volume, color = "Upper Band"), linetype = "dashed") +
  geom_line(aes(y = LowerBand_Volume, color = "Lower Band"), linetype = "dashed") +
  labs(title = "Volume Bollinger Bands for AAPL",
       x = "Date",
       y = "Volume") +
  theme_minimal() +
  scale_color_manual(values = c("Volume" = "black", "SMA" = "blue", 
                                "Upper Band" = "green", "Lower Band" = "red"))

# Arrange the two plots vertically
grid.arrange(price_plot, volume_plot, ncol = 1)