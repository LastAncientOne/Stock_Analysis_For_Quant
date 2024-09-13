# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Extract Close prices and time (index)
y <- as.numeric(Cl(Stock))  # Close prices
X <- 1:length(y)  # Time as index

# Define the Nadaraya-Watson estimator using a Gaussian kernel
nadaraya_watson <- function(X, y, bandwidth) {
  smoothed <- numeric(length(y))
  for (i in 1:length(y)) {
    weights <- dnorm(X - X[i], sd = bandwidth)
    smoothed[i] <- sum(weights * y) / sum(weights)
  }
  return(smoothed)
}

# Set parameters
window <- 20
bandwidth <- 10

# Apply the Nadaraya-Watson estimator
smoothed_prices <- nadaraya_watson(X, y, bandwidth)

# Add the Nadaraya-Watson smoothed prices to the stock data
Stock$Nadaraya_Watson <- smoothed_prices

# Create ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create ggplot chart for Nadaraya-Watson Indicator
nadaraya_chart <- ggplot(Stock, aes(x = index(Stock), y = Nadaraya_Watson)) +
  geom_line(color = 'red') +
  labs(title = "Nadaraya-Watson Indicator",
       x = "Date",
       y = "Smoothed Price") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, nadaraya_chart, ncol = 1)

# Create a combined ggplot chart for both Closing Price and Nadaraya-Watson Indicator
combined_chart <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = AAPL.Close, color = "Closing Price")) +
  geom_line(aes(y = Nadaraya_Watson, color = "Nadaraya-Watson Indicator"), linetype = "dashed") +
  labs(title = "AAPL Closing Price and Nadaraya-Watson Indicator",
       x = "Date",
       y = "Price",
       color = "Legend") + 
  scale_color_manual(values = c("Closing Price" = "blue", "Nadaraya-Watson Indicator" = "red")) +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Print the combined chart
print(combined_chart)
