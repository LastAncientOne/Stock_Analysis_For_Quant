library(quantmod)
library(ggplot2)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Heiken Ashi
HA_Close <- (Op(Stock) + Hi(Stock) + Lo(Stock) + Cl(Stock)) / 4
HA_Open <- (Op(Stock) + Cl(Stock)) / 2

for (i in 2:NROW(Stock)) {
  HA_Open[i] <- (HA_Open[i-1] + HA_Close[i-1]) / 2
}

HA_High <- pmax(HA_Open, HA_Close, Hi(Stock))
HA_Low <- pmin(HA_Open, HA_Close, Lo(Stock))

# Adding Heiken Ashi values to the Stock object
Stock$HA_Open <- HA_Open
Stock$HA_Close <- HA_Close
Stock$HA_High <- HA_High
Stock$HA_Low <- HA_Low

# Create a ggplot chart combining Closing Price and Heiken Ashi Closing Price
combined_chart <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = AAPL.Close, color = "Closing Price")) +
  geom_line(aes(y = HA_Close, color = "Heiken Ashi Close")) +
  labs(title = "AAPL Closing Price vs Heiken Ashi Closing Price",
       x = "Date",
       y = "Price") +
  scale_color_manual(name = "Legend", values = c("Closing Price" = "black", "Heiken Ashi Close" = "blue")) +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Display the chart
print(combined_chart)