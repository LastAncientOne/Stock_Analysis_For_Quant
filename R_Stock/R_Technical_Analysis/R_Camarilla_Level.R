# Load required libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Load stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Extract previous day's High, Low, Close
High <- as.numeric(Cl(Stock)[nrow(Stock)-1])
Low <- as.numeric(Lo(Stock)[nrow(Stock)-1])
Close <- as.numeric(Cl(Stock)[nrow(Stock)])

# Camarilla Pivot Calculation
H = High
L = Low
C = Close

# Calculate the pivot points and resistance/support levels
R4 = C + (H - L) * 1.1 / 2
R3 = C + (H - L) * 1.1 / 4
R2 = C + (H - L) * 1.1 / 6
R1 = C + (H - L) * 1.1 / 12
P = (H + L + C) / 3
S1 = C - (H - L) * 1.1 / 12
S2 = C - (H - L) * 1.1 / 6
S3 = C - (H - L) * 1.1 / 4
S4 = C - (H - L) * 1.1 / 2

# Create a data frame to hold the calculated levels
camarilla_levels <- data.frame(
  Level = c("R4", "R3", "R2", "R1", "P", "S1", "S2", "S3", "S4"),
  Value = c(R4, R3, R2, R1, P, S1, S2, S3, S4)
)

# Print Camarilla levels
print(camarilla_levels)

# Plot the stock data and Camarilla levels
ggplot(data = Stock) +
  geom_line(aes(x = index(Stock), y = Cl(Stock)), color = "blue") +
  geom_hline(yintercept = camarilla_levels$Value, color = "red", linetype = "dashed") +
  labs(title = "AAPL Stock Price with Camarilla Pivot Levels", 
       x = "Date", y = "Price") +
  theme_minimal() +
  theme(legend.position = "none") 
