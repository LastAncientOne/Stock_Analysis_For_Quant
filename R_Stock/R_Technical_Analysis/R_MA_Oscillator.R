# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Moving Average Oscillator
calculateMAO <- function(stock_data, n = 20) {
  # Extract closing prices
  close_prices <- Cl(stock_data)
  
  # Calculate EMA
  ema <- EMA(close_prices, n)
  
  # Calculate Moving Average Oscillator
  mao <- ((close_prices - ema) / ema) * 100
  
  # Combine into a data frame
  result <- data.frame(
    Date = index(stock_data),
    Close = as.numeric(close_prices),
    EMA = as.numeric(ema),
    MAO = as.numeric(mao)
  )
  
  return(result)
}

# Calculate indicators
mao_data <- calculateMAO(Stock)

# Create plots
price_plot <- ggplot(mao_data, aes(x = Date)) +
  geom_line(aes(y = Close, color = "Price")) +
  geom_line(aes(y = EMA, color = "EMA")) +
  labs(title = "AAPL Price and EMA",
       y = "Price",
       color = "Legend") +
  theme_minimal() +
  scale_color_manual(values = c("Price" = "black", "EMA" = "blue"))

oscillator_plot <- ggplot(mao_data, aes(x = Date, y = MAO)) +
  geom_line(color = "purple") +
  geom_hline(yintercept = 0, linetype = "dashed") +
  labs(title = "Moving Average Oscillator",
       y = "MAO (%)") +
  theme_minimal()

# Combine plots
combined_plot <- grid.arrange(price_plot, oscillator_plot, 
                              ncol = 1, heights = c(2, 1))

# Add signals
mao_data$Signal <- ifelse(mao_data$MAO > 0, "Buy", "Sell")

# Print first few rows of the data
head(mao_data)