# Load required libraries
library(quantmod)
library(TTR)
library(ggplot2)
library(gridExtra)

# Function to calculate DPO
calculateDPO <- function(prices, n = 20) {
  # Calculate the lookback period (n/2 + 1)
  lookback <- floor(n/2) + 1
  
  # Calculate Simple Moving Average
  ma <- SMA(prices, n = n)
  
  # Shift the MA forward by (n/2 + 1) periods
  ma_shifted <- lag(ma, -lookback)
  
  # Calculate DPO
  dpo <- prices - ma_shifted
  
  return(dpo)
}

# Load sample data
getSymbols('AAPL', from = '2023-01-01', to = '2024-01-01', adjust = TRUE)
stock_data <- AAPL

# Calculate DPO with 20-period setting
stock_data$DPO <- calculateDPO(Cl(stock_data), n = 20)

# Create DPO plot
dpo_plot <- ggplot(stock_data, aes(x = index(stock_data))) +
  geom_line(aes(y = DPO, color = "DPO")) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray50") +
  labs(title = "Detrended Price Oscillator (DPO)",
       x = "Date",
       y = "DPO Value") +
  theme_minimal() +
  scale_color_manual(values = c("DPO" = "blue")) +
  theme(legend.title = element_blank())

# Create price plot
price_plot <- ggplot(stock_data, aes(x = index(stock_data))) +
  geom_line(aes(y = Cl(stock_data), color = "Close Price")) +
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black")) +
  theme(legend.title = element_blank())

# Arrange plots vertically
grid.arrange(price_plot, dpo_plot, ncol = 1)