# Load required libraries
library(quantmod)
library(ggplot2)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Bollinger Bands
n <- 20  # Number of periods
k <- 2   # Number of standard deviations

Stock$SMA <- SMA(Cl(Stock), n)
Stock$SD <- k * sqrt(runSD(Cl(Stock), n))
Stock$UpperBand <- Stock$SMA + Stock$SD
Stock$LowerBand <- Stock$SMA - Stock$SD

# Plot Bollinger Bands
ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close")) +
  geom_line(aes(y = SMA, color = "SMA")) +
  geom_line(aes(y = UpperBand, color = "Upper Band"), linetype = "dashed") +
  geom_line(aes(y = LowerBand, color = "Lower Band"), linetype = "dashed") +
  labs(title = "Bollinger Bands for AAPL",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close" = "black", "SMA" = "blue", 
                                "Upper Band" = "green", "Lower Band" = "red"))
