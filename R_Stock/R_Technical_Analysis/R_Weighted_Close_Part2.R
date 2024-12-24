# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Weighted Close
Weighted_Close <- (Hi(Stock) + Lo(Stock) + (Cl(Stock) * 2)) / 4
Stock <- cbind(Stock, Weighted_Close)

# Create the stock price plot
price_plot <- ggplot(data = as.data.frame(Stock), aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +  # Closing price
  geom_line(aes(y = Weighted_Close, color = "Weighted Close")) +  # Weighted Close
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black", "Weighted Close" = "blue")) +
  theme(legend.title = element_blank())

# Create a separate plot for the Weighted Close
weighted_close_plot <- ggplot(data = as.data.frame(Stock), aes(x = index(Stock))) +
  geom_line(aes(y = Weighted_Close, color = "Weighted Close")) +  # Weighted Close
  labs(title = "AAPL Weighted Close Price",
       x = "Date",
       y = "Weighted Close Price") +
  theme_minimal() +
  scale_color_manual(values = "blue") +
  theme(legend.title = element_blank())

# Arrange the two plots vertically
grid.arrange(price_plot, weighted_close_plot, ncol = 1)