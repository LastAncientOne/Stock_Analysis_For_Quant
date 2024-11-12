# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2023-01-01', to = '2024-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Pivot Point, Supports, and Resistances
Stock$P <- (Hi(Stock) + Lo(Stock) + Cl(Stock)) / 3
Stock$S1 <- (Stock$P * 2) - Hi(Stock)
Stock$S2 <- Stock$P - (Hi(Stock) - Lo(Stock))
Stock$R1 <- (Stock$P * 2) - Lo(Stock)
Stock$R2 <- Stock$P + (Hi(Stock) - Lo(Stock))

# Create the stock price plot with Pivot Points and Support/Resistance levels
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +  # Closing price
  geom_line(aes(y = P, color = "Pivot Point")) +          # Pivot Point
  geom_line(aes(y = S1, color = "Support 1")) +           # Support 1
  geom_line(aes(y = S2, color = "Support 2")) +           # Support 2
  geom_line(aes(y = R1, color = "Resistance 1")) +        # Resistance 1
  geom_line(aes(y = R2, color = "Resistance 2")) +        # Resistance 2
  labs(title = "AAPL Stock Price with Pivot Points, Supports, and Resistances",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black", "Pivot Point" = "blue", 
                                "Support 1" = "red", "Support 2" = "orange",
                                "Resistance 1" = "green", "Resistance 2" = "purple"))

# Display the plot
grid.arrange(price_plot, ncol = 1)