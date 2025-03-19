# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(dplyr)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Define the time frame (typically 14 periods)
time_frame <- 14

# Calculate Typical Price
Typical_Price <- (Hi(Stock) + Lo(Stock) + Cl(Stock)) / 3

# Calculate Money Flow
Money_Flow <- Typical_Price * Vo(Stock)

# Identify Positive and Negative Money Flow
Positive_Money_Flow <- ifelse(Typical_Price > lag(Typical_Price, 1), Money_Flow, 0)
Negative_Money_Flow <- ifelse(Typical_Price < lag(Typical_Price, 1), Money_Flow, 0)

# Sum Positive and Negative Money Flow over the time frame
Sum_Positive_MF <- rollapply(Positive_Money_Flow, time_frame, sum, fill = NA, align = "right")
Sum_Negative_MF <- rollapply(Negative_Money_Flow, time_frame, sum, fill = NA, align = "right")

# Calculate Money Ratio
Money_Ratio <- Sum_Positive_MF / Sum_Negative_MF

# Calculate Money Flow Index
MFI <- 100 - (100 / (1 + Money_Ratio))

# Create data frames for plotting
price_data <- data.frame(
  Date = index(Stock),
  Price = as.numeric(Cl(Stock))
)

mfi_data <- data.frame(
  Date = index(Stock),
  MFI = as.numeric(MFI)
)

# Create the price plot
price_plot <- ggplot(price_data, aes(x = Date, y = Price)) +
  geom_line(color = "darkblue") +
  ggtitle("AAPL Adjusted Close Price") +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 12, face = "bold"),
    axis.title.x = element_blank()
  )

# Create the MFI plot
mfi_plot <- ggplot(mfi_data, aes(x = Date, y = MFI)) +
  geom_line(color = "darkred") +
  geom_hline(yintercept = c(20, 80), linetype = "dashed", color = "gray50") +
  ggtitle("Money Flow Index (MFI)") +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 12, face = "bold")
  )

# Combine the plots
combined_plot <- grid.arrange(
  price_plot, 
  mfi_plot, 
  heights = c(1, 1),
  ncol = 1
)