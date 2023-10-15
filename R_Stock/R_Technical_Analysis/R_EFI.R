# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Elder's Force Index (EFI)
Stock$EFI <- Stock$AAPL.Volume * (Stock$AAPL.Close - lag(Stock$AAPL.Close, order_by = index(Stock))) / 100

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for Elder's Force Index (EFI)
efi_chart <- ggplot(Stock, aes(x = index(Stock), y = EFI)) +
  geom_line(color = 'blue') +
  labs(title = "Elder's Force Index (EFI)",
       x = "Date",
       y = "EFI") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, efi_chart, ncol = 1)

