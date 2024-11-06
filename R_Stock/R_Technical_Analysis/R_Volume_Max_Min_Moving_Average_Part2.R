# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(zoo)

# Download stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate moving averages for volume and closing price
window_size <- 20  # Adjust window size for volume SMA
Stock$Volume_SMA <- SMA(Vo(Stock), n = window_size)
Stock$SMA50 <- SMA(Cl(Stock), n = 50)
Stock$SMA200 <- SMA(Cl(Stock), n = 200)

# Calculate volume max and min
Stock$Volume_Max <- rollapply(Vo(Stock), width = window_size, FUN = max, fill = NA, align = 'right')
Stock$Volume_Min <- rollapply(Vo(Stock), width = window_size, FUN = min, fill = NA, align = 'right')

# Convert xts object to data frame for ggplot
Stock_df <- data.frame(Date = index(Stock), coredata(Stock))

# Create the closing price plot (top)
price_plot <- ggplot(data = Stock_df, aes(x = Date)) +
  geom_line(aes(y = AAPL.Close, color = "Price"), size = 1) +
  geom_line(aes(y = SMA50, color = "50-day SMA"), size = 0.8, linetype = "dashed") +
  geom_line(aes(y = SMA200, color = "200-day SMA"), size = 0.8, linetype = "dashed") +
  labs(title = "AAPL Stock Prices",
       x = "Date",
       y = "Price") +
  scale_color_manual(values = c("Price" = "blue", "50-day SMA" = "orange", "200-day SMA" = "green")) +
  theme_minimal()

# Create the volume plot (bottom)
volume_plot <- ggplot(data = Stock_df, aes(x = Date)) +
  geom_line(aes(y = AAPL.Volume, color = "Volume"), size = 1) +
  geom_line(aes(y = Volume_SMA, color = "Volume SMA"), size = 0.8, linetype = "dashed") +
  geom_line(aes(y = Volume_Max, color = "Volume Max"), size = 0.8, linetype = "dotted") +
  geom_line(aes(y = Volume_Min, color = "Volume Min"), size = 0.8, linetype = "dotted") +
  labs(title = paste("AAPL Volume with", window_size, "-day SMA"),
       x = "Date",
       y = "Volume") +
  scale_color_manual(values = c("Volume" = "purple", "Volume SMA" = "red", 
                                "Volume Max" = "orange", "Volume Min" = "green")) +
  theme_minimal()

# Combine the two plots into a grid
grid.arrange(price_plot, volume_plot, ncol = 1)
