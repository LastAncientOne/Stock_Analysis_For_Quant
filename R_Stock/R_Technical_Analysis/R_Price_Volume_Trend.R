# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(TTR)

# Function to calculate PVT
calculate_pvt <- function(prices, volume) {
  # Initialize PVT vector with NA as first value
  pvt <- numeric(length(prices))
  pvt[1] <- 0
  
  # Calculate price percentage changes
  price_changes <- diff(prices) / lag(prices)[-1]
  
  # Calculate PVT for each period after the first
  for(i in 2:length(prices)) {
    pvt[i] <- price_changes[i-1] * volume[i] + pvt[i-1]
  }
  
  return(pvt)
}

# Load example data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate PVT
pvt_values <- calculate_pvt(Cl(Stock), Vo(Stock))

# Create data frame for plotting
plot_data <- data.frame(
  Date = index(Stock),
  Price = as.numeric(Cl(Stock)),
  Volume = as.numeric(Vo(Stock)),
  PVT = pvt_values
)

# Create plots
price_plot <- ggplot(plot_data, aes(x = Date)) +
  geom_line(aes(y = Price), color = "blue") +
  ggtitle("AAPL Price") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

pvt_plot <- ggplot(plot_data, aes(x = Date)) +
  geom_line(aes(y = PVT), color = "red") +
  ggtitle("Price Volume Trend (PVT)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

# Arrange plots vertically
grid.arrange(price_plot, pvt_plot, ncol = 1)