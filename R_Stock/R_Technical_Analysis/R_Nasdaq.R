# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Input parameters
symbol <- 'AAPL'
index <- 'IXIC'  # Changed from '^VXN' to '^IXIC'
start <- '2018-01-01'
end <- '2019-01-01'

# Read stock data
getSymbols(symbol, from = start, to = end, adjust = TRUE)
Stock <- get(symbol)

# Read Nasdaq data
getSymbols(index, from = start, to = end, src='yahoo')
Nasdaq <- get(index) 

# Create ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = Cl(Stock))) +
  geom_line() +
  labs(title = paste(symbol, "Closing Price"),
       x = "Date",
       y = "Price") +
  theme(plot.title = element_text(hjust = 0.5))

# Create ggplot chart for the Nasdaq
nasdaq_chart <- ggplot(Nasdaq, aes(x = index(Nasdaq), y = Cl(Nasdaq))) +
  geom_line(color = "blue") +
  labs(title = paste(index, "Closing Price"),
       x = "Date",
       y = "Nasdaq Price") +
  theme(plot.title = element_text(hjust = 0.5))

# Arrange charts using grid
grid.arrange(closing_price_chart, nasdaq_chart, ncol = 1)