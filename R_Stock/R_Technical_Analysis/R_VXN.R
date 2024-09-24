# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Input parameters
symbol <- 'AAPL'
index <- '^VXN'
start <- '2018-01-01'
end <- '2019-01-01'

# Read stock data
getSymbols(symbol, from = start, to = end, adjust = TRUE)
Stock <- get(symbol)

# Read VXN data
getSymbols(index, from = start, to = end)
VXN <- get(index)

# Create ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = Cl(Stock))) +
  geom_line() +
  labs(title = paste(symbol, "Closing Price"),
       x = "Date",
       y = "Price") +
  theme(plot.title = element_text(hjust = 0.5))

# Create ggplot chart for the VXN
vxn_chart <- ggplot(VXN, aes(x = index(VXN), y = Cl(VXN))) +
  geom_line(color = "blue") +
  labs(title = paste(index, "Closing Price"),
       x = "Date",
       y = "VXN Price") +
  theme(plot.title = element_text(hjust = 0.5))

# Arrange charts using grid
grid.arrange(closing_price_chart, vxn_chart, ncol = 1)