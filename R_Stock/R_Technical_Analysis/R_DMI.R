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

# Calculate the DMI (Dynamic Momentum Index)
Stock$sd <- runSD(Stock$AAPL.Close, n = 5)
Stock$asd <- runMean(Stock$sd, n = 10)
Stock$DMI <- 14 / (Stock$sd / Stock$asd)

# Remove unnecessary columns
Stock$TP <- NULL  # We can drop TP as requested
Stock$sd <- NULL  # Drop sd
Stock$asd <- NULL  # Drop asd

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for the Dynamic Momentum Index (DMI)
dmi_chart <- ggplot(Stock, aes(x = index(Stock), y = DMI)) +
  geom_line(color = 'blue') +
  labs(title = "Dynamic Momentum Index (DMI)",
       x = "Date",
       y = "DMI") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, dmi_chart, ncol = 1)