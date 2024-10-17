# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(TTR)  # for technical indicators

# Get stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate the Typical Price (TP)
Stock$TP <- (Hi(Stock) + Lo(Stock) + Cl(Stock)) / 3

# Calculate the CCI (Commodity Channel Index) with n periods
n <- 20  # choose the number of periods for the moving average
Stock$CCI <- CCI(Stock[, c("AAPL.High", "AAPL.Low", "AAPL.Close")], n = n)

# Remove unnecessary columns
Stock$TP <- NULL  # We can drop TP as requested

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for the Commodity Channel Index (CCI)
cci_chart <- ggplot(Stock, aes(x = index(Stock), y = CCI)) +
  geom_line(color = 'blue') +
  geom_hline(yintercept = 100, color = 'red', linetype = "dashed") +  # Add line at 100
  geom_hline(yintercept = -100, color = 'red', linetype = "dashed") + # Add line at -100
  geom_hline(yintercept = 200, color = 'darkblue', linetype = "dashed") + # Add line at 200
  geom_hline(yintercept = -200, color = 'darkblue', linetype = "dashed") + # Add line at -200
  labs(title = "Commodity Channel Index (CCI)",
       x = "Date",
       y = "CCI") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, cci_chart, ncol = 1)