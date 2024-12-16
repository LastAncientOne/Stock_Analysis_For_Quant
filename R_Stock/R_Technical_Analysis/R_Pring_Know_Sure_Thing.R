# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate KST components
price <- Cl(Stock)  # Use closing prices

# Rate of Change (ROC) calculations
ROC10 <- ROC(price, n = 10) * 100
ROC15 <- ROC(price, n = 15) * 100
ROC20 <- ROC(price, n = 20) * 100
ROC30 <- ROC(price, n = 30) * 100

# Calculate SMAs of ROC values
RCMA1 <- SMA(ROC10, n = 10)
RCMA2 <- SMA(ROC15, n = 10)
RCMA3 <- SMA(ROC20, n = 10)
RCMA4 <- SMA(ROC30, n = 15)

# KST Calculation
KST <- (RCMA1 * 1) + (RCMA2 * 2) + (RCMA3 * 3) + (RCMA4 * 4)

# Signal Line: 9-period SMA of KST
Signal_Line <- SMA(KST, n = 9)

# Convert data to data frames for ggplot
df <- data.frame(
  Date = index(Stock),
  Close = as.numeric(price),
  KST = as.numeric(KST),
  Signal = as.numeric(Signal_Line)
)

# Create the stock price plot
price_plot <- ggplot(df, aes(x = Date)) +
  geom_line(aes(y = Close, color = "Close Price")) +  
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black"))

# Create KST and Signal line plot
kst_plot <- ggplot(df, aes(x = Date)) +
  geom_line(aes(y = KST, color = "KST")) +
  geom_line(aes(y = Signal, color = "Signal Line")) +
  labs(title = "KST Indicator with Signal Line",
       x = "Date",
       y = "KST Value") +
  theme_minimal() +
  scale_color_manual(values = c("KST" = "blue", "Signal Line" = "red"))

# Arrange the two plots vertically
grid.arrange(price_plot, kst_plot, ncol = 1)