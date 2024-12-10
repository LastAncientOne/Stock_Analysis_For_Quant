# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(zoo)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate high-low differential
high_low_diff <- Hi(Stock) - Lo(Stock)

# Calculate the Single EMA (9-period EMA of high-low differential)
single_ema <- EMA(high_low_diff, n = 9)

# Calculate the Double EMA (9-period EMA of the Single EMA)
double_ema <- EMA(single_ema, n = 9)

# Calculate the EMA Ratio (Single EMA / Double EMA)
ema_ratio <- single_ema / double_ema

# Calculate the Mass Index (25-period sum of the EMA Ratio)
mass_index <- rollapply(ema_ratio, width = 25, FUN = sum, fill = NA, align = "right")

# Convert the Mass Index to a time series object for ggplot2 compatibility
mass_index <- xts(mass_index, order.by = index(Stock))

# Convert Stock data to a data frame for ggplot2 and extract the closing prices
stock_data <- fortify.zoo(Stock)
names(stock_data)[names(stock_data) == "AAPL.Close"] <- "Close"

# Create the stock price plot
price_plot <- ggplot(data = stock_data, aes(x = Index, y = Close)) +
  geom_line(color = "black") +  # Closing price
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  theme(legend.position = "top")

# Create the Mass Index plot
mass_index_data <- fortify.zoo(mass_index)
mass_index_plot <- ggplot(data = mass_index_data, aes(x = Index, y = mass_index)) +
  geom_line(color = "blue") +
  labs(title = "Mass Index (AAPL)",
       x = "Date",
       y = "Mass Index") +
  theme_minimal()

# Arrange the two plots vertically
grid.arrange(price_plot, mass_index_plot, ncol = 1)