# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(TTR) # For WMA and ROC

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate the Coppock Curve components
roc_14 <- ROC(Cl(Stock), n = 14) * 100  # 14-period RoC
roc_11 <- ROC(Cl(Stock), n = 11) * 100  # 11-period RoC

# Sum the two RoCs
roc_sum <- roc_14 + roc_11

# Calculate the 10-period WMA of the summed RoCs
coppock_curve <- WMA(roc_sum, n = 10)

# Combine into a data frame for plotting
Stock$CoppockCurve <- coppock_curve

# Create the stock price plot
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black"))

# Create the Coppock Curve plot
coppock_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = CoppockCurve, color = "Coppock Curve")) +
  labs(title = "AAPL Coppock Curve",
       x = "Date",
       y = "Coppock Curve") +
  theme_minimal() +
  scale_color_manual(values = c("Coppock Curve" = "blue"))

# Arrange the two plots vertically
grid.arrange(price_plot, coppock_plot, ncol = 1)