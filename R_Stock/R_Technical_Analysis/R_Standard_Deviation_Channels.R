# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(TTR)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Define time period for regression
n <- 20  # Rolling window size

# Function to compute standard deviation channels
compute_sd_channels <- function(prices, n) {
  lr_model <- lm(prices ~ seq_along(prices))  # Linear regression model
  trend <- predict(lr_model)  # Regression line
  residuals <- prices - trend
  sd_residuals <- sd(residuals, na.rm = TRUE)
  upper_channel <- trend + 2 * sd_residuals
  lower_channel <- trend - 2 * sd_residuals
  return(data.frame(Trend = trend, Upper = upper_channel, Lower = lower_channel))
}

# Apply rolling regression and compute SD channels
Stock$Trend <- NA
Stock$UpperChannel <- NA
Stock$LowerChannel <- NA

for (i in n:nrow(Stock)) {
  subset_prices <- Cl(Stock)[(i-n+1):i]
  channels <- compute_sd_channels(subset_prices, n)
  Stock$Trend[i] <- tail(channels$Trend, 1)
  Stock$UpperChannel[i] <- tail(channels$Upper, 1)
  Stock$LowerChannel[i] <- tail(channels$Lower, 1)
}

# Create stock price plot with Standard Deviation Channels
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +
  geom_line(aes(y = Stock$Trend, color = "Trend Line")) +
  geom_line(aes(y = Stock$UpperChannel, color = "Upper Channel"), linetype = "dashed") +
  geom_line(aes(y = Stock$LowerChannel, color = "Lower Channel"), linetype = "dashed") +
  labs(title = "AAPL Stock Price with Standard Deviation Channels",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black", "Trend Line" = "green", "Upper Channel" = "red", "Lower Channel" = "blue")) +
  theme(legend.title = element_blank())

# Arrange the plot
grid.arrange(price_plot, ncol = 1)