# Load required libraries
library(quantmod)
library(ggplot2)
library(TTR)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Define fast and slow moving averages
fastMA <- SMA(Vo(Stock), n = 5)  # 5-period moving average
slowMA <- SMA(Vo(Stock), n = 20) # 20-period moving average

# Calculate Volume Oscillator
VO <- fastMA - slowMA

# Create a data frame for plotting
df <- data.frame(Date = index(Stock), Volume = Vo(Stock), VO = VO)

# Plot the Volume Oscillator
ggplot(df, aes(x = Date)) +
  geom_line(aes(y = VO, color = "VO")) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  labs(title = "Volume Oscillator (VO) for AAPL",
       x = "Date", y = "Volume Oscillator") +
  theme_minimal()