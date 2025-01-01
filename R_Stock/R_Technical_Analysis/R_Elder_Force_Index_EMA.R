# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(TTR)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Elder Force Index (EFI)
efi <- (Cl(Stock) - Lag(Cl(Stock))) * Vo(Stock)  # EFI for each period
efi[is.na(efi)] <- 0  # Replace NA values resulting from Lag

# Calculate n-period EMA of EFI (e.g., 13-period EMA)
n <- 13
efi_ema <- EMA(efi, n)

# Combine EFI and EMA into Stock for easier plotting
Stock$EFI <- efi
Stock$EFI_EMA <- efi_ema

# Create the stock price plot
price_plot <- ggplot(data = fortify.zoo(Stock), aes(x = Index)) +
  geom_line(aes(y = AAPL.Close, color = "Close Price")) +
  labs(title = "AAPL Stock Price", x = "Date", y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close Price" = "black")) +
  theme(legend.title = element_blank())

# Create the EFI plot
efi_plot <- ggplot(data = fortify.zoo(Stock), aes(x = Index)) +
  geom_line(aes(y = EFI, color = "EFI")) +
  geom_line(aes(y = EFI_EMA, color = "EFI EMA")) +
  labs(title = "Elder Force Index (EFI) with EMA", x = "Date", y = "EFI") +
  theme_minimal() +
  scale_color_manual(values = c("EFI" = "red", "EFI EMA" = "blue")) +
  theme(legend.title = element_blank())

# Arrange the two plots vertically
grid.arrange(price_plot, efi_plot, ncol = 1)