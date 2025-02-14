# Load required libraries
library(quantmod)
library(TTR)
library(ggplot2)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate True Range (TR)
TrueRange <- ATR(HLC(Stock), n = 1)$tr

# Define period for EMA
n <- 14  # You can change this value as needed

# Calculate EMA of True Range
TR_EMA <- EMA(TrueRange, n = n)

# Calculate Volatility Ratio
Volatility_Ratio <- TrueRange / TR_EMA

# Combine data into a data frame for plotting
VR_Data <- data.frame(Date = index(Stock), Volatility_Ratio = coredata(Volatility_Ratio))

# Plot Volatility Ratio
ggplot(VR_Data, aes(x = Date, y = Volatility_Ratio)) +
  geom_line(color = 'blue') +
  labs(title = 'Volatility Ratio of AAPL', x = 'Date', y = 'Volatility Ratio') +
  theme_minimal()