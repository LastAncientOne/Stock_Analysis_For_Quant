# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Set Donchian Channel period
n_periods <- 20

# Calculate Donchian Channel components
Stock$DCupper <- runMax(Hi(Stock), n_periods)
Stock$DClower <- runMin(Lo(Stock), n_periods)
Stock$DCmiddle <- (Stock$DCupper + Stock$DClower) / 2

# Create the stock price plot with Donchian Channel
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +
  geom_line(aes(y = DCupper, color = "Upper Channel")) +
  geom_line(aes(y = DClower, color = "Lower Channel")) +
  geom_line(aes(y = DCmiddle, color = "Middle Channel")) +
  labs(title = "AAPL Stock Price with Donchian Channel",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black", 
                                "Upper Channel" = "red",
                                "Lower Channel" = "blue",
                                "Middle Channel" = "green")) +
  theme(legend.title = element_blank())

# Display the plot
grid.arrange(price_plot, ncol = 1)