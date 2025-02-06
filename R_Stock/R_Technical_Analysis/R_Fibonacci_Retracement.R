# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(dplyr)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- fortify.zoo(AAPL)  # Convert to data frame for ggplot compatibility

# Calculate Fibonacci retracement levels
high <- max(Stock$AAPL.High, na.rm = TRUE)
low <- min(Stock$AAPL.Low, na.rm = TRUE)

diff <- high - low
fib_levels <- c(high, high - 0.236 * diff, high - 0.382 * diff, high - 0.5 * diff, high - 0.618 * diff, low)
fib_labels <- c("100%", "23.6%", "38.2%", "50%", "61.8%", "0%")

# Create a data frame for Fibonacci levels
fib_df <- data.frame(Level = fib_levels, Label = fib_labels)

# Create stock price plot with Fibonacci retracement levels
price_plot <- ggplot(Stock, aes(x = Index)) +
  geom_line(aes(y = AAPL.Adjusted, color = "Close Price")) +  # Adjusted close price
  geom_hline(data = fib_df, aes(yintercept = Level, color = Label), linetype = "dashed") +
  labs(title = "AAPL Stock Price with Fibonacci Retracement Levels",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black", 
                                "100%" = "red", 
                                "23.6%" = "orange", 
                                "38.2%" = "yellow", 
                                "50%" = "green", 
                                "61.8%" = "blue", 
                                "0%" = "purple")) +
  theme(legend.title = element_blank())

# Display the plot
grid.arrange(price_plot, ncol = 1)
