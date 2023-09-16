# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Money Flow Multiplier (MF Multiplier)
MF_Multiplier <- ((Stock$AAPL.Close - Stock$AAPL.Low) - (Stock$AAPL.High - Stock$AAPL.Close)) / (Stock$AAPL.High - Stock$AAPL.Low)

# Calculate Money Flow Volume (MF Volume)
MF_Volume <- MF_Multiplier * Stock$AAPL.Volume

# Calculate 21-day Sum of MF Volume
Sum_MF_Volume <- rollapply(MF_Volume, width = 21, FUN = sum, align = "right", fill = NA)

# Calculate 21-day Sum of Volume
Sum_Volume <- rollapply(Stock$AAPL.Volume, width = 21, FUN = sum, align = "right", fill = NA)

# Calculate Chaikin Money Flow (CMF)
CMF <- Sum_MF_Volume / Sum_Volume

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for CMF
cmf_chart <- ggplot() +
  geom_line(data = data.frame(Date = index(Stock), CMF = CMF), aes(x = Date, y = CMF), color = 'green') +
  labs(title = "Chaikin Money Flow (CMF)",
       x = "Date",
       y = "CMF") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, cmf_chart, ncol = 1)
