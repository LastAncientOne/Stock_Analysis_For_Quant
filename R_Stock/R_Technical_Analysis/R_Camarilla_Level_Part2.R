# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate the Camarilla pivot points
Camarilla_pivots <- function(data) {
  high <- as.numeric(Hi(data))  # Highest price
  low <- as.numeric(Lo(data))   # Lowest price
  close <- as.numeric(Cl(data)) # Closing price
  
  # Calculate the range
  range <- high - low
  
  # Calculate the 8 Camarilla levels
  H4 <- close + (range * 1.1 / 2)
  H3 <- close + (range * 1.1 / 4)
  H2 <- close + (range * 1.1 / 6)
  H1 <- close + (range * 1.1 / 12)
  L1 <- close - (range * 1.1 / 12)
  L2 <- close - (range * 1.1 / 6)
  L3 <- close - (range * 1.1 / 4)
  L4 <- close - (range * 1.1 / 2)
  
  # Return the pivot points as a data frame
  pivots <- data.frame(Date = index(data), H4, H3, H2, H1, L1, L2, L3, L4, Close = close)
  return(pivots)
}

# Calculate the Camarilla pivots for AAPL stock
camarilla_values <- Camarilla_pivots(Stock)

# Print the Camarilla pivot points
print(head(camarilla_values))

# Plot the Camarilla pivots along with the close price
ggplot(camarilla_values, aes(x = Date)) +
  geom_line(aes(y = Close), color = "black", size = 1) +
  geom_line(aes(y = H4), color = "red", linetype = "dashed") +
  geom_line(aes(y = H3), color = "blue", linetype = "dashed") +
  geom_line(aes(y = H2), color = "green", linetype = "dashed") +
  geom_line(aes(y = H1), color = "purple", linetype = "dashed") +
  geom_line(aes(y = L1), color = "purple", linetype = "dashed") +
  geom_line(aes(y = L2), color = "green", linetype = "dashed") +
  geom_line(aes(y = L3), color = "blue", linetype = "dashed") +
  geom_line(aes(y = L4), color = "red", linetype = "dashed") +
  labs(title = "Camarilla Pivot Points with Close Price for AAPL",
       x = "Date",
       y = "Price") +
  theme_minimal()