# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Function to calculate Swing Index
calculate_swing_index <- function(data, T = 50) {
  Oy <- Lag(Op(data))
  Ot <- Op(data)
  Hy <- Lag(Hi(data))
  Ht <- Hi(data)
  Ly <- Lag(Lo(data))
  Lt <- Lo(data)
  Cy <- Lag(Cl(data))
  Ct <- Cl(data)
  
  K <- pmax(abs(Ht - Cy), abs(Lt - Cy))
  
  R <- ifelse(
    K == abs(Ht - Cy), (Ht - Cy) - 0.5 * (Lt - Cy) + 0.25 * (Cy - Oy),
    ifelse(
      K == abs(Lt - Cy), (Lt - Cy) - 0.5 * (Ht - Cy) + 0.25 * (Cy - Oy),
      (Ht - Lt) + 0.25 * (Cy - Oy)
    )
  )
  
  SI <- 50 * (((Cy - Ct) + (0.5 * (Cy - Oy)) + (0.25 * (Ct - Ot))) / (R * K * T))
  
  return(SI)
}

# Calculate Swing Index
Stock$SwingIndex <- calculate_swing_index(Stock)

# Create the stock price plot
price_plot <- ggplot(fortify.zoo(Stock), aes(x = Index)) +
  geom_line(aes(y = Cl(AAPL), color = "Close Price")) +  # Closing price
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black")) +
  theme(legend.title = element_blank())

# Create the Swing Index plot
swing_index_plot <- ggplot(fortify.zoo(Stock), aes(x = Index)) +
  geom_line(aes(y = SwingIndex, color = "Swing Index")) +
  labs(title = "AAPL Swing Index",
       x = "Date",
       y = "Swing Index") +
  theme_minimal() +
  scale_color_manual(values = c("Swing Index" = "blue")) +
  theme(legend.title = element_blank())

# Arrange the two plots vertically
grid.arrange(price_plot, swing_index_plot, ncol = 1)