# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate the PMO components
calculate_PMO <- function(price, time_period = 35) {
  # Calculate the Smoothing Multiplier
  smoothing_multiplier <- 2 / time_period
  
  # Calculate daily price change percentage
  price_change_pct <- (price / lag(price) - 1) * 100
  
  # Custom Smoothing Function for 35-period
  custom_smoothing_35 <- filter(price_change_pct, rep(smoothing_multiplier, 35), sides = 1)
  
  # Calculate PMO Line
  pmo_line <- filter(custom_smoothing_35 * 10, rep(smoothing_multiplier, 20), sides = 1)
  
  # Calculate PMO Signal Line (10-period EMA)
  pmo_signal <- EMA(pmo_line, n = 10)
  
  return(list(pmo_line = pmo_line, pmo_signal = pmo_signal))
}

# Calculate PMO and PMO Signal Line
pmo_result <- calculate_PMO(Cl(Stock))

# Create the stock price plot
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +  # Closing price
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black"))

# Create PMO plot
pmo_plot <- ggplot(data = data.frame(Date = index(Stock), PMO = pmo_result$pmo_line, Signal = pmo_result$pmo_signal), 
                   aes(x = Date)) +
  geom_line(aes(y = PMO, color = "PMO Line")) +
  geom_line(aes(y = Signal, color = "PMO Signal Line")) +
  labs(title = "AAPL PMO and Signal Line",
       x = "Date",
       y = "PMO Value") +
  theme_minimal() +
  scale_color_manual(values = c("PMO Line" = "blue", "PMO Signal Line" = "red"))

# Arrange the two plots vertically
grid.arrange(price_plot, pmo_plot, ncol = 1)