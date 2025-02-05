# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Stochastic Oscillator
stoch_osc <- stoch(HLC(Stock), nFastK = 14, nFastD = 3, nSlowD = 3)

# Add Stochastic %K and %D to the Stock data frame
Stock$Stoch_K <- stoch_osc$fastK
Stock$Stoch_D <- stoch_osc$fastD

# Create the stock price plot
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +  # Closing price
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black")) +
  theme(legend.title = element_blank())

# Plot Stochastic Oscillator
stoch_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Stock$Stoch_K, color = "%K")) +
  geom_line(aes(y = Stock$Stoch_D, color = "%D"), linetype = "dashed") +
  labs(title = "AAPL Stochastic Oscillator",
       x = "Date",
       y = "Stochastic Value") +
  theme_minimal() +
  scale_color_manual(values = c("%K" = "blue", "%D" = "red")) +
  theme(legend.title = element_blank())

# Arrange the two plots vertically
grid.arrange(price_plot, stoch_plot, ncol = 1)