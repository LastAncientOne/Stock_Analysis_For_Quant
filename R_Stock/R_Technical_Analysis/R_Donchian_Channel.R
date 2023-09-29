# Load required libraries
library(quantmod)
library(ggplot2)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Donchian Channel
n <- 20  # Number of periods

Stock$High <- runMax(Hi(Stock), n)
Stock$Low <- runMin(Lo(Stock), n)
Stock$MiddleLine <- (Stock$High + Stock$Low) / 2

# Plot Donchian Channel
ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close")) +
  geom_line(aes(y = MiddleLine, color = "Middle Line")) +
  geom_line(aes(y = High, color = "High Line"), linetype = "dashed") +
  geom_line(aes(y = Low, color = "Low Line"), linetype = "dashed") +
  labs(title = "Donchian Channel Indicator for AAPL",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close" = "black", "Middle Line" = "blue", 
                                "High Line" = "green", "Low Line" = "red"))
