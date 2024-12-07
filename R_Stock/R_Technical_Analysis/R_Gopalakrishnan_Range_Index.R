# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Set window size for GAPO calculation
n <- 14  # You can change this to any desired window size

# Calculate the Gopalakrishnan Range Index (GAPO)
highs <- runMax(Hi(Stock), n)
lows <- runMin(Lo(Stock), n)
gapo <- log(highs - lows) / log(n)

# Add GAPO to the Stock data
Stock$GAPO <- gapo

# Create the stock price plot
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +  # Closing price
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black"))

# Create GAPO plot
gapo_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = GAPO, color = "GAPO")) +
  labs(title = "Gopalakrishnan Range Index (GAPO) for AAPL",
       x = "Date",
       y = "GAPO") +
  theme_minimal() +
  scale_color_manual(values = c("GAPO" = "blue"))

# Arrange the two plots vertically
grid.arrange(price_plot, gapo_plot, ncol = 1)