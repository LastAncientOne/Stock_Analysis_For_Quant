# Load required libraries
library(quantmod)
library(ggplot2)
library(TTR)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Negative Volume Index (NVI)
calculate_NVI <- function(stock) {
  close_prices <- Cl(stock)
  volumes <- Vo(stock)
  nvi <- rep(NA, length(close_prices))
  
  # Initialize first NVI value at 1000
  nvi[1] <- 1000
  
  for (i in 2:length(close_prices)) {
    if (volumes[i] < volumes[i - 1]) {
      nvi[i] <- nvi[i - 1] + ((close_prices[i] - close_prices[i - 1]) / close_prices[i - 1]) * nvi[i - 1]
    } else {
      nvi[i] <- nvi[i - 1]
    }
  }
  
  return(xts(nvi, order.by = index(stock)))
}

# Compute NVI
Stock$NVI <- calculate_NVI(Stock)

# Convert to data frame for ggplot
nvi_df <- data.frame(Date = index(Stock), Close = Cl(Stock), NVI = Stock$NVI)

# Plot NVI
p1 <- ggplot(nvi_df, aes(x = Date)) +
  geom_line(aes(y = Close), color = 'blue') +
  ggtitle("AAPL Closing Price") +
  ylab("Price") + xlab("Date") +
  theme_minimal()

p2 <- ggplot(nvi_df, aes(x = Date)) +
  geom_line(aes(y = NVI), color = 'red') +
  ggtitle("AAPL Negative Volume Index (NVI)") +
  ylab("NVI") + xlab("Date") +
  theme_minimal()

# Arrange plots
gridExtra::grid.arrange(p1, p2, ncol = 1)