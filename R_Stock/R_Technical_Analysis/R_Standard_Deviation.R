library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Standard Deviation Indicator
Stock$std <- runSD(Cl(Stock), n = 20)  # 20-period standard deviation

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Create a ggplot chart for Standard Deviation
std_chart <- ggplot(Stock, aes(x = index(Stock), y = std)) +
  geom_line(color = 'Red') +
  labs(title = "20-Period Standard Deviation",
       x = "Date",
       y = "Standard Deviation") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, std_chart, ncol = 1)
