# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Bollinger Bands and %B
bb <- BBands(Cl(Stock), n = 20, sd = 2) # 20-period moving average, 2 standard deviations
Stock$PctB <- (Cl(Stock) - bb$dn) / (bb$up - bb$dn) # Calculate %B

# Create the stock price plot
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +  # Closing price
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black"))

# Create the %B plot
pb_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = PctB, color = "%B")) +
  labs(title = "AAPL %B Indicator",
       x = "Date",
       y = "%B") +
  theme_minimal() +
  scale_color_manual(values = c("%B" = "blue")) +
  geom_hline(yintercept = 1, linetype = "dashed", color = "red") + # Upper bound
  geom_hline(yintercept = 0, linetype = "dashed", color = "red")   # Lower bound

# Arrange the two plots vertically
grid.arrange(price_plot, pb_plot, ncol = 1)