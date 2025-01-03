# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Define the ADXVMA function
ADXVMA <- function(price, length) {
  # Convert price to numeric vector if it's xts object
  if (is.xts(price)) {
    price <- as.numeric(price)
  }
  
  n <- length(price)
  pdm <- numeric(n)
  mdm <- numeric(n)
  pdi <- numeric(n)
  mdi <- numeric(n)
  DI_Diff <- numeric(n)
  DI_Sum <- numeric(n)
  ma <- price
  WeightDM <- length
  WeightDI <- length
  WeightDX <- length
  ChandeEMA <- length
  out <- numeric(n)
  HHV <- numeric(n)
  LLV <- numeric(n)
  
  # Initialize first values
  pdm[1] <- 0
  mdm[1] <- 0
  pdi[1] <- 0
  mdi[1] <- 0
  out[1] <- 0
  ma[1] <- price[1]
  HHV[1] <- 0
  LLV[1] <- 0
  
  for (i in 2:n) {
    # Calculate Plus and Minus Directional Movement
    pdm[i] <- max(price[i] - price[i-1], 0)
    mdm[i] <- max(price[i-1] - price[i], 0)
    
    # Smoothed DM
    pdm[i] <- (pdm[i-1] * (WeightDM - 1) + pdm[i]) / WeightDM
    mdm[i] <- (mdm[i-1] * (WeightDM - 1) + mdm[i]) / WeightDM
    
    # Calculate TR and DI
    TR <- pdm[i] + mdm[i]
    if (TR > 0) {
      pdi[i] <- pdm[i] / TR
      mdi[i] <- mdm[i] / TR
    } else {
      pdi[i] <- pdi[i-1]
      mdi[i] <- mdi[i-1]
    }
    
    # Smooth DI values
    pdi[i] <- (pdi[i-1] * (WeightDI - 1) + pdi[i]) / WeightDI
    mdi[i] <- (mdi[i-1] * (WeightDI - 1) + mdi[i]) / WeightDI
    
    # Calculate DX
    DI_Diff[i] <- abs(pdi[i] - mdi[i])
    DI_Sum[i] <- pdi[i] + mdi[i]
    out[i] <- ifelse(DI_Sum[i] > 0, DI_Diff[i] / DI_Sum[i], out[i-1])
    
    # Smooth DX
    out[i] <- (out[i-1] * (WeightDX - 1) + out[i]) / WeightDX
    
    # Calculate HHV and LLV
    HHV[i] <- max(out[i], out[i-1])
    LLV[i] <- min(out[i], out[i-1])
    
    # Calculate Volatility Index and MA
    diff <- HHV[i] - LLV[i]
    VI <- ifelse(diff > 0, (out[i] - LLV[i]) / diff, 0)
    ma[i] <- ((ChandeEMA - VI) * ma[i-1] + VI * price[i]) / ChandeEMA
  }
  
  # Convert back to xts object if input was xts
  if (is.xts(price)) {
    ma <- xts(ma, order.by = index(price))
  }
  
  return(ma)
}

# Example usage with stock data
stock_symbol <- 'AAPL'
start_date <- '2016-01-01'
end_date <- '2018-01-01'

# Retrieve stock data
getSymbols(stock_symbol, from = start_date, to = end_date, adjust = TRUE)
price <- Cl(get(stock_symbol))
length <- 14  # You can adjust the length as needed

# Calculate ADXVMA
adxvma <- ADXVMA(price, length)

# Create ADXVMA plot
adxvma_plot <- ggplot(data = data.frame(Date = index(price), ADXVMA = as.numeric(adxvma)), 
                      aes(x = Date)) +
  geom_line(aes(y = ADXVMA, color = "ADXVMA")) +
  labs(title = "ADXVMA",
       x = "Date",
       y = "ADXVMA") +
  theme_minimal() +
  scale_color_manual(values = c("ADXVMA" = "blue")) +
  theme(legend.title = element_blank())

# Create stock price plot
price_plot <- ggplot(data = data.frame(Date = index(price), Price = as.numeric(price)), 
                     aes(x = Date)) +
  geom_line(aes(y = Price, color = "Close Price")) +
  labs(title = paste(stock_symbol, "Stock Price"),
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black")) +
  theme(legend.title = element_blank())

# Arrange the two plots vertically
grid.arrange(price_plot, adxvma_plot, ncol = 1)
