# Load required libraries
library(quantmod)
library(ggplot2)
library(TTR)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Function to calculate Parabolic SAR
calculate_psar <- function(high, low, close, 
                           init_af = 0.02, 
                           max_af = 0.2, 
                           af_step = 0.02) {
  n <- length(high)
  psar <- numeric(n)
  direction <- numeric(n)  # 1 for long, -1 for short
  af <- numeric(n)
  ep <- numeric(n)
  
  # Initialize first values
  direction[1] <- ifelse(close[1] > close[2], 1, -1)
  psar[1] <- ifelse(direction[1] == 1, min(low[1:2]), max(high[1:2]))
  af[1] <- init_af
  ep[1] <- ifelse(direction[1] == 1, max(high[1:2]), min(low[1:2]))
  
  # Calculate PSAR for remaining periods
  for(i in 2:n) {
    # Previous PSAR becomes the new one before adjustment
    psar[i] <- psar[i-1]
    
    # Update extreme point
    if(direction[i-1] == 1) {  # If long
      if(high[i] > ep[i-1]) {
        ep[i] <- high[i]
        af[i] <- min(af[i-1] + af_step, max_af)
      } else {
        ep[i] <- ep[i-1]
        af[i] <- af[i-1]
      }
      
      # Calculate PSAR
      psar[i] <- psar[i-1] + af[i] * (ep[i] - psar[i-1])
      
      # Adjust PSAR if needed
      psar[i] <- max(psar[i], max(low[i-1], low[i]))
      
      # Check for trend reversal
      if(low[i] < psar[i]) {
        direction[i] <- -1
        psar[i] <- max(ep[i], high[i])
        ep[i] <- low[i]
        af[i] <- init_af
      } else {
        direction[i] <- 1
      }
      
    } else {  # If short
      if(low[i] < ep[i-1]) {
        ep[i] <- low[i]
        af[i] <- min(af[i-1] + af_step, max_af)
      } else {
        ep[i] <- ep[i-1]
        af[i] <- af[i-1]
      }
      
      # Calculate PSAR
      psar[i] <- psar[i-1] - af[i] * (psar[i-1] - ep[i])
      
      # Adjust PSAR if needed
      psar[i] <- min(psar[i], min(high[i-1], high[i]))
      
      # Check for trend reversal
      if(high[i] > psar[i]) {
        direction[i] <- 1
        psar[i] <- min(ep[i], low[i])
        ep[i] <- high[i]
        af[i] <- init_af
      } else {
        direction[i] <- -1
      }
    }
  }
  
  return(list(
    psar = psar,
    direction = direction,
    af = af,
    ep = ep
  ))
}

# Apply the PSAR calculation to the AAPL data
high <- as.numeric(Stock$AAPL.High)
low <- as.numeric(Stock$AAPL.Low)
close <- as.numeric(Stock$AAPL.Close)

psar_results <- calculate_psar(high, low, close)

# Create a data frame for plotting
plot_data <- data.frame(
  Date = index(Stock),
  High = high,
  Low = low,
  Close = close,
  PSAR = psar_results$psar
)

# Create the plot using ggplot2
ggplot(plot_data, aes(x = Date)) +
  geom_line(aes(y = Close), color = "black") +
  geom_point(aes(y = PSAR, color = factor(psar_results$direction)), size = 1) +
  scale_color_manual(values = c("-1" = "red", "1" = "green"), 
                     labels = c("Short", "Long"),
                     name = "Position") +
  labs(title = "AAPL Stock Price with Parabolic SAR",
       x = "Date",
       y = "Price") +
  theme_minimal()