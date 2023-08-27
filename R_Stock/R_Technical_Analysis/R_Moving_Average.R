# Load necessary libraries
library(quantmod)

# Download stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate moving average
window_size <- 20  # You can adjust this value
moving_average <- SMA(Cl(Stock), n = window_size)

# Plot the stock prices and moving average
plot(index(Stock), Cl(Stock), type = "l", col = "blue", main = Stock + " Stock Prices")
lines(index(moving_average), moving_average, col = "red")
legend("topleft", legend = c("Stock Price", paste("SMA", window_size)), col = c("blue", "red"), lty = c(1, 1))

library(quantmod)
library(ggplot2)

getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate moving averages
Stock$SMA50 <- SMA(Cl(Stock), n = 50)
Stock$SMA200 <- SMA(Cl(Stock), n = 200)

# Create a grid chart
chart <- ggplot(data = Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Price"), size = 1) +
  geom_line(aes(y = SMA50, color = "50-day SMA"), size = 0.8, linetype = "dashed") +
  geom_line(aes(y = SMA200, color = "200-day SMA"), size = 0.8, linetype = "dashed") +
  labs(title = paste(Stock + " Stock Price with Moving Averages"),
       x = "Date",
       y = "Price") +
  scale_color_manual(values = c("Price" = "blue", "50-day SMA" = "orange", "200-day SMA" = "green")) +
  theme_minimal()

print(chart)