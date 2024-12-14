# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols(c('AAPL', '^GSPC'), from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL
Benchmark <- GSPC

# Calculate Price Relative indicators
PriceRelative_Close <- Cl(Stock) / Cl(Benchmark)
PriceRelative_Open  <- Op(Stock) / Cl(Benchmark)
PriceRelative_High  <- Hi(Stock) / Cl(Benchmark)
PriceRelative_Low   <- Lo(Stock) / Cl(Benchmark)

# Create data frame for Price Relative Close indicator for plotting
price_relative_df <- data.frame(
  Date = index(PriceRelative_Close),
  Close = as.numeric(PriceRelative_Close)
)

# Create AAPL stock price plot
price_plot <- ggplot(data.frame(Date = index(Stock), Close = as.numeric(Cl(Stock))), 
                     aes(x = Date, y = Close)) +
  geom_line(color = "black") +  # Closing price
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal()

# Create Price Relative plot
price_relative_plot <- ggplot(price_relative_df, aes(x = Date, y = Close)) +
  geom_line(color = "blue") +  # Price Relative Close
  labs(title = "Price Relative (AAPL / S&P 500)",
       x = "Date",
       y = "Price Relative") +
  theme_minimal()

# Arrange the two plots vertically
grid.arrange(price_plot, price_relative_plot, ncol = 1)