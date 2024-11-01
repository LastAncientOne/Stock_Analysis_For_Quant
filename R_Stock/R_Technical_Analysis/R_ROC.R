# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate the Typical Price (TP)
Stock$TP <- (Hi(Stock) + Lo(Stock) + Cl(Stock)) / 3

# Calculate the Rate of Change (ROC) with n periods
n <- 12  # Set the number of periods for ROC
Stock$ROC <- ((Stock$AAPL.Close - lag(Stock$AAPL.Close, n)) / lag(Stock$AAPL.Close, n)) * 100

# Remove unnecessary columns
Stock$TP <- NULL  # We can drop TP as requested

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for the Rate of Change (ROC)
roc_chart <- ggplot(Stock, aes(x = index(Stock), y = ROC)) +
  geom_line(color = 'blue') +
  geom_hline(yintercept = 0, color = 'red', linetype = "dashed") +  # Add line at 0
  labs(title = "Rate of Change (ROC)",
       x = "Date",
       y = "ROC (%)") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, roc_chart, ncol = 1)