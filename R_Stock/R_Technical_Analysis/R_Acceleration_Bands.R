# Load required libraries
library(quantmod)
library(ggplot2)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

n <- 7

# Calculate Acceleration Bands
Stock$ABUpper <- rollapply(Stock$AAPL.High, width = n, FUN = mean, align = "right", fill = NA) + 
  (0.1 * rollapply(Stock$AAPL.High - Stock$AAPL.Low, width = n, FUN = mean, align = "right", fill = NA))

Stock$ABLower <- rollapply(Stock$AAPL.Low, width = n, FUN = mean, align = "right", fill = NA) - 
  (0.1 * rollapply(Stock$AAPL.High - Stock$AAPL.Low, width = n, FUN = mean, align = "right", fill = NA))

# Plot Acceleration Bands
ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = Cl(Stock), color = "Close")) +
  geom_line(aes(y = ABUpper, color = "Upper Band"), linetype = "dashed") +
  geom_line(aes(y = ABLower, color = "Lower Band"), linetype = "dashed") +
  labs(title = "Acceleration Bands for AAPL",
       x = "Date",
       y = "Price") +
  theme_minimal() +
  scale_color_manual(values = c("Close" = "black",
                                "Upper Band" = "green", "Lower Band" = "red"))
