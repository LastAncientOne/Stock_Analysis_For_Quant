# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Price Channels
Stock$UpperChannel <- runMax(Hi(Stock), n = 20)  # 20-day high
Stock$LowerChannel <- runMin(Lo(Stock), n = 20)  # 20-day low
Stock$Centerline <- (Stock$UpperChannel + Stock$LowerChannel) / 2  # Centerline

# Create the stock price plot with Price Channels
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +  # Closing price
  geom_line(aes(y = UpperChannel, color = "Upper Channel"), linetype = "dashed") +
  geom_line(aes(y = LowerChannel, color = "Lower Channel"), linetype = "dashed") +
  geom_line(aes(y = Centerline, color = "Centerline"), linetype = "dotted") +
  labs(title = "AAPL Stock Price with 20-Day Price Channels",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black", 
                                "Upper Channel" = "blue", 
                                "Lower Channel" = "red", 
                                "Centerline" = "purple"))

# Create the volume plot
volume_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Vo(Stock), color = "Volume")) +  # Volume
  labs(title = "AAPL Volume",
       x = "Date",
       y = "Volume") +
  theme_minimal() +
  scale_color_manual(values = c("Volume" = "black"))

# Arrange the two plots vertically
grid.arrange(price_plot, volume_plot, ncol = 1)
