# Load necessary libraries
library(quantmod)
library(TTR)
library(ggplot2)
library(gridExtra)

# Download stock data (AAPL example)
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', auto.assign = TRUE)
Stock <- AAPL

# Step 1: Calculate High+Low+Close and PrevHigh+Low+Close
Stock$HighLowClose <- Stock$AAPL.High + Stock$AAPL.Low + Stock$AAPL.Close
Stock$PrevHighLowClose <- lag(Stock$HighLowClose, 1)

# Step 2: Calculate R
Stock$R <- ifelse(Stock$HighLowClose > Stock$PrevHighLowClose, 1,
                  ifelse(Stock$HighLowClose < Stock$PrevHighLowClose, -1, NA))
Stock$R <- na.locf(Stock$R, na.rm = FALSE)  # Forward fill NA values

# Step 3: Calculate dm (daily movement) and cumulative cm (cumulative movement)
Stock$dm <- Stock$AAPL.High - Stock$AAPL.Low
Stock$cm <- cumsum(Stock$dm)

# Step 4: Calculate Vol*PriceChange (Volume * Close Price Change)
Stock$VolPriceChange <- Stock$AAPL.Volume * diff(Stock$AAPL.Close, lag = 1)
Stock$VolPriceChange[is.na(Stock$VolPriceChange)] <- 0  # Replace initial NA with 0

# Step 5: Calculate KO (Klinger Oscillator)
# Short-term and long-term exponential moving averages
KO_short <- EMA(Stock$VolPriceChange, n = 13)
KO_long <- EMA(Stock$VolPriceChange, n = 34)
Stock$KO <- KO_short - KO_long

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price", x = "Date", y = "Price") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Create a ggplot chart for KO
ko_chart <- ggplot(Stock, aes(x = index(Stock), y = KO)) +
  geom_line(color = "blue") +
  labs(title = "Klinger Oscillator (KO)", x = "Date", y = "KO Value") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using gridExtra
grid.arrange(closing_price_chart, ko_chart, ncol = 1)