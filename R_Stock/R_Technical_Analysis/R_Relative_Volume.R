# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Set look-back period (e.g., 20 days)
look_back <- 20

# Calculate average volume over the look-back period
average_volume <- runMean(Vo(Stock), n = look_back, cumulative = FALSE)

# Calculate Relative Volume (RVOL)
RVOL <- Vo(Stock) / average_volume

# Create the stock price plot
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +  # Closing price
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black"))

# Create the RVOL plot
rvol_data <- data.frame(Date = index(Stock), RVOL = coredata(RVOL))
rvol_plot <- ggplot(rvol_data, aes(x = Date, y = RVOL)) +
  geom_line(color = "blue") +
  labs(title = "Relative Volume (RVOL) for AAPL",
       x = "Date",
       y = "RVOL") +
  theme_minimal()

# Arrange the two plots vertically
grid.arrange(price_plot, rvol_plot, ncol = 1)