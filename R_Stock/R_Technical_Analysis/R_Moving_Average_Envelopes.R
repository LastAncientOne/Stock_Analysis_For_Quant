# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate 20-day Simple Moving Average
sma20 <- SMA(Cl(Stock), n = 20)

# Calculate Upper and Lower Envelopes (2.5% above and below the 20-day SMA)
upper_envelope <- sma20 * 1.025
lower_envelope <- sma20 * 0.975

# Combine data into a data frame for plotting
data <- data.frame(
  Date = index(Stock),
  Close = as.numeric(Cl(Stock)),
  SMA20 = as.numeric(sma20),
  UpperEnvelope = as.numeric(upper_envelope),
  LowerEnvelope = as.numeric(lower_envelope)
)

# Create the stock price plot with envelopes
price_plot <- ggplot(data, aes(x = Date)) +
  geom_line(aes(y = Close, color = "Close Price")) +
  geom_line(aes(y = SMA20, color = "20-day SMA")) +
  geom_line(aes(y = UpperEnvelope, color = "Upper Envelope"), linetype = "dashed") +
  geom_line(aes(y = LowerEnvelope, color = "Lower Envelope"), linetype = "dashed") +
  labs(title = "AAPL Stock Price with Moving Average Envelope",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black", 
                                "20-day SMA" = "blue", 
                                "Upper Envelope" = "red", 
                                "Lower Envelope" = "green"))

# Display the plot
grid.arrange(price_plot, ncol = 1)