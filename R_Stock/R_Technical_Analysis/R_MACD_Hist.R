# Load required libraries
library(quantmod)
library(dplyr)
library(TTR)
library(tidyr)
library(ggplot2)
library(patchwork)  # For combining plots

# Define stock symbols and date range
symbols <- c('AMD', 'NVDA', 'MSFT', 'GOOGL')
start_date <- as.Date("2021-12-01")
end_date <- as.Date("2022-09-02")

# Function to retrieve closing prices
get_close_prices <- function(symbol) {
  stock_data <- tryCatch({
    getSymbols(symbol, from = start_date, to = end_date, auto.assign = FALSE)
  }, error = function(e) {
    message(paste("Error fetching data for", symbol, ":", e$message))
    return(NULL)
  })
  
  if (is.null(stock_data)) return(NULL)
  
  close_prices <- data.frame(Date = index(stock_data), Close = as.numeric(Cl(stock_data)))
  close_prices$Symbol <- symbol
  return(close_prices)
}

# Function to calculate MACD and histogram
get_macd_histogram <- function(symbol) {
  stock_data <- tryCatch({
    getSymbols(symbol, from = start_date, to = end_date, auto.assign = FALSE)
  }, error = function(e) {
    message(paste("Error fetching data for", symbol, ":", e$message))
    return(NULL)
  })
  
  if (is.null(stock_data)) return(NULL)
  
  close_prices <- Cl(stock_data)
  macd_data <- MACD(close_prices, nFast = 12, nSlow = 26, nSig = 9, maType = EMA)
  
  macd_df <- data.frame(Date = index(macd_data), coredata(macd_data)) %>%
    mutate(Histogram = macd - signal) %>%
    drop_na()
  
  macd_df$Symbol <- symbol
  return(macd_df)
}

# Retrieve closing prices and MACD histograms
close_prices <- lapply(symbols, get_close_prices) %>% bind_rows()
macd_histograms <- lapply(symbols, get_macd_histogram) %>% bind_rows()

# Function to plot closing price and MACD histogram
plot_price_and_macd <- function(symbol) {
  price_df <- close_prices %>% filter(Symbol == symbol)
  macd_df <- macd_histograms %>% filter(Symbol == symbol)
  
  if (nrow(price_df) == 0 | nrow(macd_df) == 0) {
    message(paste("No data available for", symbol))
    return()
  }
  
  # Closing price plot
  price_plot <- ggplot(price_df, aes(x = Date, y = Close)) +
    geom_line(color = "blue", size = 1) +
    labs(title = paste(symbol, "Closing Price"), x = "Date", y = "Price") +
    theme_minimal()
  
  # MACD histogram plot
  macd_plot <- ggplot(macd_df, aes(x = Date, y = Histogram, fill = Histogram > 0)) +
    geom_bar(stat = "identity", show.legend = FALSE) +
    scale_fill_manual(values = c("red", "green")) +
    labs(title = paste(symbol, "MACD Histogram"), x = "Date", y = "MACD Histogram") +
    theme_minimal()
  
  # Combine both plots
  price_plot / macd_plot
}

# Example: Plot for NVDA
plot_price_and_macd("NVDA")