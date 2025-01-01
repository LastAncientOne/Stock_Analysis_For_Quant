# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(TTR)

# Load stock data (e.g., Apple) and benchmark index data (e.g., S&P 500)
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
getSymbols('^GSPC', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)

# Define stock and index data
Stock <- AAPL
Index <- GSPC

# Set the moving average period (e.g., 20-day moving average)
ma_period <- 20

# Calculate Moving Averages for Stock and Index
MA_Stock <- SMA(Cl(Stock), ma_period)
MA_Index <- SMA(Cl(Index), ma_period)

# Calculate Performance Index (PI)
PI <- (Cl(Stock) * Cl(Index)) / (Cl(Stock) * Cl(Index) * MA_Stock * MA_Index)

# Create the stock price plot
price_plot <- ggplot() +
  geom_line(aes(x = index(Stock), y = Cl(Stock), color = "AAPL Close Price")) +
  geom_line(aes(x = index(Index), y = Cl(Index), color = "S&P 500 Close Price")) +
  labs(title = "AAPL Stock and S&P 500 Index Prices",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("AAPL Close Price" = "black", "S&P 500 Close Price" = "blue")) +
  theme(legend.title = element_blank())

# Plot the Performance Index
pi_plot <- ggplot(data = data.frame(Date = index(PI), PI = coredata(PI)), aes(x = Date, y = PI)) +
  geom_line(color = "red") +
  labs(title = "Performance Index (PI) of AAPL vs S&P 500",
       x = "Date",
       y = "Performance Index") +
  theme_minimal()

# Arrange the two plots vertically
grid.arrange(price_plot, pi_plot, ncol = 1)