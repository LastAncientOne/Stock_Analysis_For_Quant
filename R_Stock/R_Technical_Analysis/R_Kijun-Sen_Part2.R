library(quantmod)
library(ggplot2)

# Get stock data for AAPL from 2016-01-01 to 2018-01-01
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Kijun-sen (Base Line): (26-Period High + 26-Period Low) / 2
Stock$KS <- (runMax(Hi(Stock), n = 26) + runMin(Lo(Stock), n = 26)) / 2

# Combine Closing Price and Kijun-sen in a single ggplot chart
combined_chart <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = AAPL.Close), color = "black", size = 1) +  # Closing Price in black
  geom_line(aes(y = KS), color = "blue", size = 1) +  # Kijun-sen in blue
  labs(title = "AAPL Closing Price with Kijun-sen (Base Line)",
       x = "Date",
       y = "Price") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Plot the combined chart
print(combined_chart)