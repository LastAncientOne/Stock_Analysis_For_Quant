# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate the slope of the closing prices
# Convert the index to numeric for regression
dates <- as.numeric(index(Stock))
closing_prices <- Cl(Stock)

# Perform linear regression
model <- lm(closing_prices ~ dates)

# Extract the slope
slope <- coef(model)[2]

# Create the stock price plot
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +  # Closing price
  labs(title = paste("AAPL Stock Price\nSlope:", round(slope, 4)),
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black"))

# Arrange the plot
grid.arrange(price_plot, ncol = 1)

# Print the slope
print(paste("The slope of AAPL stock prices from 2016-01-01 to 2018-01-01 is:", round(slope, 4)))