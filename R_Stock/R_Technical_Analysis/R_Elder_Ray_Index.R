# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Define the EMA period
n_period <- 13

# Calculate EMA
Stock$EMA <- EMA(Cl(Stock), n = n_period)

# Calculate Bull Power and Bear Power
Stock$BullPower <- Hi(Stock) - Stock$EMA
Stock$BearPower <- Lo(Stock) - Stock$EMA

# Create the stock price plot
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +  # Closing price
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black")) +
  theme(legend.title = element_blank())

# Create Elder Ray Index plot (Bull Power and Bear Power)
eri_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = BullPower, color = "Bull Power")) +
  geom_line(aes(y = BearPower, color = "Bear Power")) +
  labs(title = "Elder Ray Index (ERI)",
       x = "Date",
       y = "ERI Value") +
  theme_minimal() +
  scale_color_manual(values = c("Bull Power" = "green", "Bear Power" = "red")) +
  theme(legend.title = element_blank())

# Arrange the two plots vertically
grid.arrange(price_plot, eri_plot, ncol = 1)