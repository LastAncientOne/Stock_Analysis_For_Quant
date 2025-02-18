# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(TTR)

# Function to calculate price ratio
calculate_price_ratio <- function(stock_data, reference_price) {
  # Calculate price ratio using Adjusted closing prices
  price_ratio <- Ad(stock_data) / reference_price
  return(price_ratio)
}

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
stock_data <- AAPL

# Get the reference price (first day's closing price)
reference_price <- as.numeric(Ad(stock_data)[1])

# Calculate price ratio
price_ratio <- calculate_price_ratio(stock_data, reference_price)

# Convert to data frame for plotting
plot_data <- data.frame(
  Date = index(stock_data),
  Price = as.numeric(Ad(stock_data)),
  PriceRatio = as.numeric(price_ratio)
)

# Create price plot
price_plot <- ggplot(plot_data, aes(x = Date, y = Price)) +
  geom_line(color = "blue") +
  theme_minimal() +
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price ($)") +
  theme(plot.title = element_text(hjust = 0.5))

# Create price ratio plot
ratio_plot <- ggplot(plot_data, aes(x = Date, y = PriceRatio)) +
  geom_line(color = "red") +
  theme_minimal() +
  labs(title = "AAPL Price Ratio",
       x = "Date",
       y = "Price Ratio") +
  theme(plot.title = element_text(hjust = 0.5))

# Combine plots
combined_plot <- grid.arrange(price_plot, ratio_plot, ncol = 1)

# Print summary statistics
summary_stats <- data.frame(
  Metric = c("Starting Price", "Ending Price", "Starting Ratio", "Ending Ratio"),
  Value = c(
    first(plot_data$Price),
    last(plot_data$Price),
    first(plot_data$PriceRatio),
    last(plot_data$PriceRatio)
  )
)
print(summary_stats)