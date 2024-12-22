# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate the 30-day moving average
moving_average <- SMA(Cl(Stock), n = 30)

# Calculate the slope
# Define time points (using the index of the moving average)
time_points <- index(moving_average)

# Use two points to calculate slope (e.g., first and last valid MA points)
valid_points <- na.omit(moving_average)

if (length(valid_points) >= 2) {
  # Choose two points for slope calculation
  y1 <- as.numeric(valid_points[1])
  y2 <- as.numeric(valid_points[length(valid_points)])
  x1 <- as.numeric(time_points[1])
  x2 <- as.numeric(time_points[length(valid_points)])
  
  # Calculate the change in y and change in x
  delta_y <- y2 - y1
  delta_x <- x2 - x1
  
  # Calculate the slope
  slope <- delta_y / delta_x
  
  # Print the slope
  print(paste("Slope of the moving average:", slope))
} else {
  print("Not enough valid data points for slope calculation.")
}

# Create the stock price plot with moving average
price_plot <- ggplot() +
  geom_line(data = Stock, aes(x = index(Stock), y = Cl(Stock), color = "Close Price")) +  # Closing price
  geom_line(aes(x = time_points, y = moving_average, color = "30-day Moving Average")) +  # Moving average
  labs(title = "AAPL Stock Price with Moving Average",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black", "30-day Moving Average" = "blue"))

# Arrange the plot vertically
grid.arrange(price_plot, ncol = 1)