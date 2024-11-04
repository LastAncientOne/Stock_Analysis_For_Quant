library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate the Typical Price (TP)
Stock$TP <- (Hi(Stock) + Lo(Stock) + Cl(Stock)) / 3

# Define the number of periods for ROCR
n <- 12  # Set n to 12 as per your requirement

# Calculate the Rate of Change Rate (ROCR)
Stock$ROCR <- (Stock$AAPL.Adjusted / lag(Stock$AAPL.Adjusted, n) - 1) * 100  # Percentage change

# Remove unnecessary columns
Stock$TP <- NULL  # We can drop TP as requested

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for the Rate of Change Rate (ROCR)
rocr_chart <- ggplot(Stock, aes(x = index(Stock), y = ROCR)) +
  geom_line(color = 'blue') +
  geom_hline(yintercept = 0, color = 'red', linetype = "dashed") +  # Add line at 0
  labs(title = "Rate of Change Rate (ROCR)",
       x = "Date",
       y = "ROCR (%)") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, rocr_chart, ncol = 1)