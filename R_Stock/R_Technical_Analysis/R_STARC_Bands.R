# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(TTR)

# Function to calculate STARC Bands
calculateSTARCBands <- function(data, n = 15, multiplier = 2) {
  # Calculate SMA
  data$SMA <- SMA(Cl(data), n = n)
  
  # Calculate ATR
  data$ATR <- ATR(HLC(data), n = n)[, "atr"]
  
  # Calculate STARC Bands
  data$UpperSTARC <- data$SMA + (data$ATR * multiplier)
  data$LowerSTARC <- data$SMA - (data$ATR * multiplier)
  
  return(data)
}

# Get stock data
getSymbols('AAPL', from='2023-01-01', to='2024-01-01', adjust=TRUE)
stock_data <- AAPL

# Calculate STARC Bands
stock_data <- calculateSTARCBands(stock_data)

# Convert to data frame for ggplot
df <- data.frame(
  Date = index(stock_data),
  Close = as.numeric(Cl(stock_data)),
  Upper = as.numeric(stock_data$UpperSTARC),
  Lower = as.numeric(stock_data$LowerSTARC),
  SMA = as.numeric(stock_data$SMA),
  ATR = as.numeric(stock_data$ATR)
)

# Remove any rows with NA values
df <- na.omit(df)

# Create main price chart with STARC Bands
price_chart <- ggplot(df, aes(x = Date)) +
  geom_line(aes(y = Close, color = "Price")) +
  geom_line(aes(y = Upper, color = "Upper STARC")) +
  geom_line(aes(y = Lower, color = "Lower STARC")) +
  geom_line(aes(y = SMA, color = "SMA")) +
  scale_color_manual(values = c(
    "Price" = "black",
    "Upper STARC" = "red",
    "Lower STARC" = "green",
    "SMA" = "blue"
  )) +
  labs(
    title = "AAPL Price with STARC Bands",
    x = "Date",
    y = "Price",
    color = "Indicators"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.position = "bottom"
  )

# Create ATR chart
atr_chart <- ggplot(df, aes(x = Date)) +
  geom_line(aes(y = ATR), color = "purple") +
  labs(
    title = "Average True Range (ATR)",
    x = "Date",
    y = "ATR"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

# Arrange both charts
grid.arrange(price_chart, atr_chart, 
             ncol = 1, 
             heights = c(2, 1))
