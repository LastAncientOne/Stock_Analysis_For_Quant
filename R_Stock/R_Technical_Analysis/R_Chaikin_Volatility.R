# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Parameters
n <- 10  # Number of periods for the EMA

# Calculate High-Low Average as Exponential Moving Average of (High - Low)
High_Low_Diff <- Hi(Stock) - Lo(Stock)
High_Low_Average <- EMA(High_Low_Diff, n = n)

# Calculate Chaikin Volatility
Chaikin_Volatility <- ((High_Low_Average - lag(High_Low_Average, n)) / lag(High_Low_Average, n)) * 100

# Add Chaikin Volatility to the stock data
Stock$Chaikin_Volatility <- Chaikin_Volatility

# Create the stock price plot
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price"), size = 1) +  # Closing price
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black")) +
  theme(legend.title = element_blank())

# Create the Chaikin Volatility plot
volatility_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Chaikin_Volatility, color = "Chaikin Volatility"), size = 1) +  # Chaikin Volatility
  labs(title = "Chaikin Volatility",
       x = "Date",
       y = "Volatility (%)") +
  theme_minimal() +
  scale_color_manual(values = c("Chaikin Volatility" = "blue")) +
  theme(legend.title = element_blank())

# Arrange the two plots side by side
grid.arrange(price_plot, volatility_plot, ncol = 1)