# Load required libraries
library(quantmod)
library(TTR)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Key Price
Stock$KeyPrice <- (Hi(Stock) + Lo(Stock) + Cl(Stock)) / 3

# Calculate Trend
Stock$Trend <- with(Stock, ifelse(KeyPrice > lag(KeyPrice, 1), Vo(Stock),
                                  ifelse(KeyPrice < lag(KeyPrice, 1), -Vo(Stock), 0)))

# Set parameters for EMA periods
short_period <- 34
long_period <- 55
signal_period <- 13

# Calculate KVO (Klinger Volume Oscillator)
Stock$KVO <- EMA(Stock$Trend, n = short_period) - EMA(Stock$Trend, n = long_period)

# Calculate KVO Signal line
Stock$KVOSignal <- EMA(Stock$KVO, n = signal_period)

# Create KVO plot
kvo_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = KVO, color = "KVO")) +         # KVO line
  geom_line(aes(y = KVOSignal, color = "KVO Signal")) +  # KVO Signal line
  labs(title = "Klinger Volume Oscillator (KVO)",
       x = "Date",
       y = "KVO") +
  theme_minimal() +
  scale_color_manual(values = c("KVO" = "blue", "KVO Signal" = "red")) +
  theme(legend.title = element_blank())

# Create stock price plot
price_plot <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close Price")) +
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black")) +
  theme(legend.title = element_blank())

# Arrange the two plots vertically
grid.arrange(price_plot, kvo_plot, ncol = 1)