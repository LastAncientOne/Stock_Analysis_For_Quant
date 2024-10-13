# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(zoo)  # For rollapply

# Get stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Number of periods and weight factor for Center of Gravity (COG)
n <- 10  # Number of periods (adjust as needed)
w <- 0.5  # Weight factor
m <- (n - 1) %/% 2  # Calculate midpoint using integer division

# Calculate the Center of Gravity (COG)
Stock$COG <- rollapply(Stock$AAPL.Adjusted, width = n, FUN = function(x) {
  sum_weights <- sum((1:n) * w)  # Corrected weight sum calculation
  weighted_sum <- sum((1:n) * x)  # Weighted sum of prices
  return(weighted_sum / sum_weights)  # Calculate COG
}, align = 'right', fill = NA)

# Calculate the average COG
avg_cog <- mean(Stock$COG, na.rm = TRUE)

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Adjusted)) +
  geom_line() +
  labs(title = "AAPL Adjusted Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for the Center of Gravity (COG) with average COG line
cog_chart <- ggplot(Stock, aes(x = index(Stock), y = COG)) +
  geom_line(color = 'blue') +
  geom_hline(yintercept = avg_cog, linetype = "dashed", color = "red", size = 1) +
  labs(title = "Center of Gravity (COG) with Average",
       x = "Date",
       y = "COG") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, cog_chart, ncol = 1)