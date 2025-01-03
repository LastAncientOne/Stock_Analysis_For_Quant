# Load required libraries
library(quantmod)
library(ggplot2)
library(tidyverse)
library(gridExtra)

# Function to calculate STARC Bands
calculate_starc_bands <- function(stock_data, n = 15, multiplier = 2) {
  # Calculate SMA
  stock_data$SMA <- SMA(Cl(stock_data), n = n)
  
  # Calculate ATR
  stock_data$ATR <- ATR(HLC(stock_data), n = n)[, 'atr']
  
  # Calculate STARC Bands
  stock_data$Upper_STARC <- stock_data$SMA + (stock_data$ATR * multiplier)
  stock_data$Lower_STARC <- stock_data$SMA - (stock_data$ATR * multiplier)
  
  return(stock_data)
}

# Function to plot STARC Bands
plot_starc_bands <- function(stock_data, symbol = "Stock") {
  # Convert to data frame for ggplot
  df <- data.frame(
    Date = index(stock_data),
    Close = as.numeric(Cl(stock_data)),
    SMA = as.numeric(stock_data$SMA),
    Upper_STARC = as.numeric(stock_data$Upper_STARC),
    Lower_STARC = as.numeric(stock_data$Lower_STARC),
    ATR = as.numeric(stock_data$ATR)
  )
  
  # Create price chart with STARC Bands
  price_chart <- ggplot(df, aes(x = Date)) +
    geom_line(aes(y = Close, color = "Price")) +
    geom_line(aes(y = SMA, color = "SMA")) +
    geom_line(aes(y = Upper_STARC, color = "Upper STARC"), linetype = "dashed") +
    geom_line(aes(y = Lower_STARC, color = "Lower STARC"), linetype = "dashed") +
    scale_color_manual(values = c(
      "Price" = "black",
      "SMA" = "blue",
      "Upper STARC" = "red",
      "Lower STARC" = "red"
    )) +
    labs(
      title = paste(symbol, "- STARC Bands"),
      x = "Date",
      y = "Price",
      color = "Legend"
    ) +
    theme_minimal() +
    theme(legend.position = "bottom")
  
  # Create ATR chart
  atr_chart <- ggplot(df, aes(x = Date, y = ATR)) +
    geom_line(color = "purple") +
    labs(
      title = "Average True Range (ATR)",
      x = "Date",
      y = "ATR"
    ) +
    theme_minimal()
  
  # Arrange both charts
  grid.arrange(price_chart, atr_chart, ncol = 1, heights = c(2, 1))
}

# Example usage
# Get sample data
getSymbols("AAPL", from = "2023-01-01", to = "2024-01-01", adjust = TRUE)

# Calculate STARC Bands
starc_data <- calculate_starc_bands(AAPL, n = 15, multiplier = 2)

# Generate plots
plot_starc_bands(starc_data, symbol = "AAPL")

# Optional: Generate trading signals
generate_starc_signals <- function(stock_data) {
  signals <- data.frame(
    Date = index(stock_data),
    Signal = NA
  )
  
  close_prices <- Cl(stock_data)
  
  # Generate signals
  signals$Signal <- ifelse(close_prices > stock_data$Upper_STARC, "Sell",
                           ifelse(close_prices < stock_data$Lower_STARC, "Buy", "Hold"))
  
  return(signals)
}

# Get trading signals
signals <- generate_starc_signals(starc_data)
head(signals)
