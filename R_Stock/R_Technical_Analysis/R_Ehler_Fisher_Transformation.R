# Load required libraries
library(quantmod)
library(ggplot2)
library(TTR)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate MidPoint (MP) and Intermediate (I)
High <- Hi(Stock)
Low <- Lo(Stock)
Close <- Cl(Stock)

# MidPoint (MP)
MP <- (High + Low) / 2

# Intermediate term (I)
n_periods <- 10 # Number of periods can be set as desired, for example 10
Highest_High <- runMax(High, n_periods)
Lowest_Low <- runMin(Low, n_periods)

I <- 2 * (MP - Lowest_Low) / (Highest_High - Lowest_Low) - 1

# Smoothing intermediate term with 5-period EMA
Ismoothed <- EMA(I, n = 5)

# Applying Fisher Transformation and smoothing with a 3-period EMA
EFT <- EMA(log((1 + Ismoothed) / (1 - Ismoothed)), n = 3)

# Create data frame for plotting
data <- data.frame(Date = index(Stock), Close = as.numeric(Close), EFT = as.numeric(EFT))

# Plot stock price and EFT
price_plot <- ggplot(data, aes(x = Date)) +
  geom_line(aes(y = Close, color = "Close Price")) +
  labs(title = "AAPL Stock Price",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black")) +
  theme(legend.title = element_blank())

eft_plot <- ggplot(data, aes(x = Date)) +
  geom_line(aes(y = EFT, color = "Ehlers Fisher Transformation")) +
  labs(title = "Ehlers Fisher Transformation (EFT)",
       x = "Date",
       y = "EFT Value") +
  theme_minimal() +
  scale_color_manual(values = c("Ehlers Fisher Transformation" = "blue")) +
  theme(legend.title = element_blank())

# Arrange the two plots vertically
grid.arrange(price_plot, eft_plot, ncol = 1)