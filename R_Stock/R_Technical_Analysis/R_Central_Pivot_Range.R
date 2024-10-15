# Load necessary libraries
library(quantmod)
library(ggplot2)

# Download stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate the Central Pivot Range (CPR)
Stock$Pivot <- (Hi(Stock) + Lo(Stock) + Cl(Stock)) / 3.0  # Pivot Point
Stock$BC <- (Hi(Stock) + Lo(Stock)) / 2.0  # Bottom Central
Stock$TC <- Stock$Pivot + (Stock$Pivot - Stock$BC)  # Top Central

# Create a grid chart for the stock prices and CPR
chart <- ggplot(data = Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Price"), size = 1) +
  geom_line(aes(y = Pivot, color = "Pivot"), size = 0.8, linetype = "dashed") +
  geom_line(aes(y = TC, color = "Top Central"), size = 0.8, linetype = "dashed") +
  geom_line(aes(y = BC, color = "Bottom Central"), size = 0.8, linetype = "dashed") +
  labs(title = paste("AAPL Stock Price with Central Pivot Range (CPR)"),
       x = "Date",
       y = "Price") +
  scale_color_manual(values = c("Price" = "blue", "Pivot" = "orange", "Top Central" = "green", "Bottom Central" = "red")) +
  theme_minimal()

# Display the chart
print(chart)