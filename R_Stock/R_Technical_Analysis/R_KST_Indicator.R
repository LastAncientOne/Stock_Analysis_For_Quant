# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Function to calculate Rate of Change (ROC)
roc <- function(x, n) {
  (x / lag(x, n) - 1) * 100
}

# Calculate smoothed ROC values for KST Indicator
r1 <- SMA(roc(Cl(Stock), 10), n = 10)
r2 <- SMA(roc(Cl(Stock), 15), n = 10)
r3 <- SMA(roc(Cl(Stock), 20), n = 10)
r4 <- SMA(roc(Cl(Stock), 30), n = 15)

# Compute KST Indicator
Stock$KST <- r1 + (2 * r2) + (3 * r3) + (4 * r4)

# Compute Signal Line (SMA of KST)
Stock$KST_Signal <- SMA(Stock$KST, n = 9)

# Create the stock price plot
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +  # Closing price
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black")) +
  theme(legend.title = element_blank())

# Create the KST Indicator plot
kst_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = KST, color = "KST Indicator")) +
  geom_line(aes(y = KST_Signal, color = "Signal Line"), linetype = "dashed") +
  labs(title = "AAPL KST Indicator",
       x = "Date",
       y = "KST Value") +
  theme_minimal() +
  scale_color_manual(values = c("KST Indicator" = "blue", "Signal Line" = "red")) +
  theme(legend.title = element_blank())

# Arrange the two plots vertically
grid.arrange(price_plot, kst_plot, ncol = 1)
