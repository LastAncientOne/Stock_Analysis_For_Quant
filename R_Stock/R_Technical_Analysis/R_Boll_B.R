# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Bollinger Bands
bbands <- BBands(Cl(Stock), n = 20, sd = 2)
Stock$UpperBand <- bbands$up
Stock$LowerBand <- bbands$dn
Stock$BollB <- (Cl(Stock) - Stock$LowerBand) / (Stock$UpperBand - Stock$LowerBand)

# Create the stock price plot with Bollinger Bands
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +  # Closing price
  geom_line(aes(y = Stock$UpperBand, color = "Upper Band"), linetype = "dashed") +
  geom_line(aes(y = Stock$LowerBand, color = "Lower Band"), linetype = "dashed") +
  labs(title = "AAPL Stock Price with Bollinger Bands",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black", "Upper Band" = "red", "Lower Band" = "blue")) +
  theme(legend.title = element_blank())

# Plot Bollinger %B
bollB_plot <- ggplot(Stock, aes(x = index(Stock), y = BollB)) +
  geom_line(color = "purple") +
  labs(title = "AAPL Boll %B",
       x = "Date",
       y = "Boll %B") +
  theme_minimal()

# Arrange the two plots vertically
grid.arrange(price_plot, bollB_plot, ncol = 1)