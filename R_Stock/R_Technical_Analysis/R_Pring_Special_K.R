library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2012-01-01', to = '2020-01-01', adjust = TRUE)
Stock <- AAPL

# Define a function to calculate the weighted SMAs of ROC as per Pring's Special K formula
calculate_special_k <- function(stock_data) {
  # Calculate the ROC values and their weighted SMAs
  ROC10  <- SMA(ROC(Cl(stock_data), n = 10) * 1, n = 10)
  ROC15  <- SMA(ROC(Cl(stock_data), n = 15) * 2, n = 10)
  ROC20  <- SMA(ROC(Cl(stock_data), n = 20) * 3, n = 10)
  ROC30  <- SMA(ROC(Cl(stock_data), n = 30) * 4, n = 15)
  ROC40  <- SMA(ROC(Cl(stock_data), n = 40) * 1, n = 50)
  ROC65  <- SMA(ROC(Cl(stock_data), n = 65) * 2, n = 65)
  ROC75  <- SMA(ROC(Cl(stock_data), n = 75) * 3, n = 75)
  ROC100 <- SMA(ROC(Cl(stock_data), n = 100) * 4, n = 100)
  ROC195 <- SMA(ROC(Cl(stock_data), n = 195) * 1, n = 130)
  ROC265 <- SMA(ROC(Cl(stock_data), n = 265) * 2, n = 130)
  ROC390 <- SMA(ROC(Cl(stock_data), n = 390) * 3, n = 130)
  ROC530 <- SMA(ROC(Cl(stock_data), n = 530) * 4, n = 195)
  
  # Sum all the weighted ROC values to get Special K
  Special_K <- ROC10 + ROC15 + ROC20 + ROC30 + ROC40 + ROC65 +
    ROC75 + ROC100 + ROC195 + ROC265 + ROC390 + ROC530
  return(Special_K)
}

# Calculate the Special K indicator
Stock$Special_K <- calculate_special_k(Stock)

# Create the stock price plot
price_plot <- ggplot(data = as.data.frame(index(Stock)), aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +  
  labs(title = "AAPL Stock Price", x = "Date", y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black"))

# Create the Special K plot
special_k_plot <- ggplot(data = as.data.frame(index(Stock)), aes(x = index(Stock))) +
  geom_line(aes(y = Stock$Special_K, color = "Special K")) +  
  labs(title = "AAPL Special K Indicator", x = "Date", y = "Special K") +
  theme_minimal() +
  scale_color_manual(values = c("Special K" = "blue"))

# Arrange the two plots vertically
grid.arrange(price_plot, special_k_plot, ncol = 1)