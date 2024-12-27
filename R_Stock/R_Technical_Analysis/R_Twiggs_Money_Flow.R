# Load required libraries
library(quantmod)
library(TTR)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Define parameters
n <- 21  # You can adjust the period for the EMA

# Calculate Twiggs Money Flow components
Lowest_Low <- pmin(Lo(Stock), lag(Cl(Stock), k = 1, default = first(Cl(Stock))))
Highest_High <- pmax(Hi(Stock), lag(Cl(Stock), k = 1, default = first(Cl(Stock))))
Volume_Adjusted <- Vo(Stock) * ((Cl(Stock) - Lowest_Low) / (Highest_High - Lowest_Low) * 2 - 1)

# Calculate TMF using EMA
TMF <- EMA(Volume_Adjusted, n = n) / EMA(Vo(Stock), n = n) * 100

# Combine TMF with stock data
Stock$TMF <- TMF

# Plot Closing Price and TMF
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black")) +
  theme(legend.title = element_blank())

tmf_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = TMF, color = "Twiggs Money Flow")) +
  labs(title = "Twiggs Money Flow (TMF)",
       x = "Date",
       y = "TMF") +
  theme_minimal() +
  scale_color_manual(values = c("Twiggs Money Flow" = "blue")) +
  theme(legend.title = element_blank())

# Arrange the two plots vertically
grid.arrange(price_plot, tmf_plot, ncol = 1)