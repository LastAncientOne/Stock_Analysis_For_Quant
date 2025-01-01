# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Define the limit move value (T)
T <- 1  # Adjust T as needed

# Calculate Swing Index (SI)
calculate_SI <- function(Stock, T) {
  Oy <- lag(Op(Stock), 1)  # Yesterday's Open
  Ot <- Op(Stock)          # Today's Open
  Hy <- lag(Hi(Stock), 1)  # Yesterday's High
  Ht <- Hi(Stock)          # Today's High
  Ly <- lag(Lo(Stock), 1)  # Yesterday's Low
  Lt <- Lo(Stock)          # Today's Low
  Cy <- lag(Cl(Stock), 1)  # Yesterday's Close
  Ct <- Cl(Stock)          # Today's Close
  
  K <- pmax(Ht - Cy, Lt - Cy)
  
  # Calculate R based on the largest of Ht - Cy, Lt - Cy, Ht - Lt
  R <- ifelse(Ht - Cy >= Lt - Cy & Ht - Cy >= Ht - Lt, 
              (Ht - Cy) - 0.5 * (Lt - Cy) + 0.25 * (Cy - Oy),
              ifelse(Lt - Cy >= Ht - Cy & Lt - Cy >= Ht - Lt,
                     (Lt - Cy) - 0.5 * (Ht - Cy) + 0.25 * (Cy - Oy),
                     (Ht - Lt) + 0.25 * (Cy - Oy)))
  
  # Calculate Swing Index (SI)
  SI <- 50 * ((Cy - Ct) + 0.5 * (Cy - Oy) + 0.25 * (Ct - Ot)) / (R * K * T)
  return(SI)
}

# Calculate SI for the dataset
Stock$Swing_Index <- calculate_SI(Stock, T)

# Plot Closing Price and Swing Index
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +  # Closing price
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black")) +
  theme(legend.title = element_blank())

si_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Swing_Index, color = "Swing Index")) +  # Swing Index
  labs(title = "AAPL Swing Index",
       x = "Date",
       y = "Swing Index") +
  theme_minimal() +
  scale_color_manual(values = c("Swing Index" = "blue")) +
  theme(legend.title = element_blank())

# Arrange the two plots vertically
grid.arrange(price_plot, si_plot, ncol = 1)