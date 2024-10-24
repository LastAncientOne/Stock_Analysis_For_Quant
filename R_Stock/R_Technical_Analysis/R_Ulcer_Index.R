# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Define the number of periods for Ulcer Index calculation
n <- 14  # typically 14 periods are used for Ulcer Index

# Calculate rolling maximum and drawdown
Stock$Max_Close <- rollapply(Stock$AAPL.Adjusted, width = n, FUN = max, align = "right", fill = NA)
Stock$Percent_Drawdown <- 100 * (Stock$AAPL.Adjusted - Stock$Max_Close) / Stock$Max_Close

# Calculate the Ulcer Index
Stock$Percent_Drawdown_Squared <- Stock$Percent_Drawdown^2
Stock$Squared_Average <- rollapply(Stock$Percent_Drawdown_Squared, width = n, FUN = mean, align = "right", fill = NA)
Stock$Ulcer_Index <- sqrt(Stock$Squared_Average)

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Adjusted)) +
  geom_line() +
  labs(title = "AAPL Adjusted Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for the Ulcer Index
ui_chart <- ggplot(Stock, aes(x = index(Stock), y = Ulcer_Index)) +
  geom_line(color = 'blue') +
  labs(title = "Ulcer Index",
       x = "Date",
       y = "Ulcer Index") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, ui_chart, ncol = 1)