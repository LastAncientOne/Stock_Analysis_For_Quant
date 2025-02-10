# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate True Range
Stock$TR <- pmax(Hi(Stock) - Lo(Stock), 
                 abs(Hi(Stock) - Lag(Cl(Stock), 1)), 
                 abs(Lag(Cl(Stock), 1) - Lo(Stock)), na.rm = TRUE)

# Create the stock price plot
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black")) +
  theme(legend.title = element_blank())

# Plot True Range
tr_plot <- ggplot(Stock, aes(x = index(Stock), y = TR)) +
  geom_line(color = "blue") +
  labs(title = "AAPL True Range",
       x = "Date",
       y = "True Range") +
  theme_minimal()

# Arrange the two plots vertically
grid.arrange(price_plot, tr_plot, ncol = 1)
