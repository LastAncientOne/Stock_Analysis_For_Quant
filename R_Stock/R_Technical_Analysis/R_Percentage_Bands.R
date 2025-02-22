# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(TTR)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Function to calculate percentage bands using closing prices
calculate_close_bands <- function(data, percent = 0.10) {
  df <- data.frame(
    Date = index(data),
    Close = as.numeric(Cl(data)),
    stringsAsFactors = FALSE
  )
  
  df$Upper <- df$Close * (1 + percent)
  df$Lower <- df$Close * (1 - percent)
  
  for(i in 2:nrow(df)) {
    df$Lower[i] <- max(df$Lower[i], df$Lower[i-1])
    df$Upper[i] <- min(df$Upper[i], df$Upper[i-1])
  }
  
  return(df)
}

# Function to calculate percentage bands using High/Low prices
calculate_hl_bands <- function(data, percent = 0.10) {
  df <- data.frame(
    Date = index(data),
    High = as.numeric(Hi(data)),
    Low = as.numeric(Lo(data)),
    Close = as.numeric(Cl(data)),
    stringsAsFactors = FALSE
  )
  
  df$Upper <- df$Low * (1 + percent)
  df$Lower <- df$High * (1 - percent)
  
  return(df)
}

# Calculate both types of bands
close_bands <- calculate_close_bands(Stock)
hl_bands <- calculate_hl_bands(Stock)

# Create plot for closing price bands with legend
plot_close_bands <- ggplot(close_bands, aes(x = Date)) +
  geom_line(aes(y = Close, color = "Close Price")) +
  geom_line(aes(y = Upper, color = "Upper Band"), linetype = "dashed") +
  geom_line(aes(y = Lower, color = "Lower Band"), linetype = "dashed") +
  ggtitle("Percentage Bands (Using Closing Prices)") +
  scale_color_manual(
    name = "Legend",
    values = c("Close Price" = "black", "Upper Band" = "red", "Lower Band" = "blue")
  ) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

# Create plot for High/Low bands with legend
plot_hl_bands <- ggplot(hl_bands, aes(x = Date)) +
  geom_line(aes(y = Close, color = "Close Price")) +
  geom_line(aes(y = Upper, color = "Upper Band"), linetype = "dashed") +
  geom_line(aes(y = Lower, color = "Lower Band"), linetype = "dashed") +
  ggtitle("Percentage Bands (Using High/Low Prices)") +
  scale_color_manual(
    name = "Legend",
    values = c("Close Price" = "black", "Upper Band" = "red", "Lower Band" = "blue")
  ) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

# Display both plots
grid.arrange(plot_close_bands, plot_hl_bands, ncol = 1)