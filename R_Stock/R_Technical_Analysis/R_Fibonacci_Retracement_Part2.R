# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Fibonacci retracement levels
high <- max(Hi(Stock))
low <- min(Lo(Stock))

diff <- high - low
fib_levels <- c(high, high - 0.236 * diff, high - 0.382 * diff, high - 0.5 * diff, high - 0.618 * diff, low)

# Create stock price plot with Fibonacci retracement levels
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +  # Closing price
  geom_hline(yintercept = fib_levels, linetype = "dashed", color = c("red", "orange", "yellow", "green", "blue", "purple")) +
  labs(title = "AAPL Stock Price with Fibonacci Retracement Levels",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black")) +
  theme(legend.title = element_blank())

# Display the plot
grid.arrange(price_plot, ncol = 1)