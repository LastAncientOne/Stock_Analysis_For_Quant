# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate the Typical Price (TP) and 20-period SMA of TP
Stock$TP <- (Hi(Stock) + Lo(Stock) + Cl(Stock)) / 3
Stock$SMA_TP <- rollapply(Stock$TP, width = 20, FUN = mean, align = 'right', fill = NA)

# Calculate the Mean Deviation
Stock$Mean_Deviation <- rollapply(Stock$TP, width = 20, FUN = function(x) mean(abs(x - mean(x))), align = 'right', fill = NA)

# Calculate CCI
Stock$CCI <- (Stock$TP - Stock$SMA_TP) / (0.015 * Stock$Mean_Deviation)

# Create the stock price plot
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +  # Closing price
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black"))

# Create the CCI plot
cci_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = CCI, color = "CCI")) +
  labs(title = "Commodity Channel Index (CCI) for AAPL",
       x = "Date",
       y = "CCI") +
  theme_minimal() +
  scale_color_manual(values = c("CCI" = "blue"))

# Arrange the two plots vertically
grid.arrange(price_plot, cci_plot, ncol = 1)