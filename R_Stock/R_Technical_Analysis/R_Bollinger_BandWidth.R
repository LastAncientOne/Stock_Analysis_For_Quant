# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Bollinger Bands
bb <- BBands(Cl(Stock), n = 20, maType = SMA, sd = 2)

# Calculate Bollinger BandWidth
Stock$BandWidth <- ((bb$up - bb$dn) / bb$mavg) * 100

# Create the stock price plot
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +  # Closing price
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black"))

# Create the Bollinger BandWidth plot
bandwidth_plot <- ggplot(Stock, aes(x = index(Stock), y = BandWidth)) +
  geom_line(color = "blue") +
  labs(title = "AAPL Bollinger BandWidth",
       x = "Date",
       y = "BandWidth (%)") +
  theme_minimal()

# Arrange the two plots vertically
grid.arrange(price_plot, bandwidth_plot, ncol = 1)