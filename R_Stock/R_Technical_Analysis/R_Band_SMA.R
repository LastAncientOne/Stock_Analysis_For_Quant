# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(TTR)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate price envelopes (20-day SMA with 2.5% bands)
sma <- SMA(Cl(Stock), n = 20)
upper_band <- sma * 1.025
lower_band <- sma * 0.975

# Create data frame for plotting
df <- data.frame(
  Date = index(Stock),
  Price = as.numeric(Cl(Stock)),
  SMA = as.numeric(sma),
  Upper = as.numeric(upper_band),
  Lower = as.numeric(lower_band)
)

# Create the plot
ggplot(df, aes(x = Date)) +
  geom_line(aes(y = Price, color = "Price"), size = 1) +
  geom_line(aes(y = SMA, color = "SMA"), size = 1) +
  geom_line(aes(y = Upper, color = "Upper Band"), linetype = "dashed") +
  geom_line(aes(y = Lower, color = "Lower Band"), linetype = "dashed") +
  scale_color_manual(values = c(
    "Price" = "black",
    "SMA" = "blue",
    "Upper Band" = "red",
    "Lower Band" = "red"
  )) +
  labs(
    title = "AAPL Price with SMA & Band",
    x = "Date",
    y = "Price",
    color = "Legend"
  ) +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    plot.title = element_text(hjust = 0.5)
  )

# Generate trading signals
df$Signal <- ifelse(df$Price <= df$Lower, "Buy",
                    ifelse(df$Price >= df$Upper, "Sell", "Hold")
)

# Print the first few signals
head(subset(df, Signal != "Hold"), 10)