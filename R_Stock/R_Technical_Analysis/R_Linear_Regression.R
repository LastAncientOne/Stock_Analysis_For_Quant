library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols(c('AAPL', 'QQQ'), from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock_AAPL <- AAPL
Stock_QQQ <- QQQ

# Extract adjusted close prices
df1 <- AAPL[, "AAPL.Adjusted"]
df2 <- QQQ[, "QQQ.Adjusted"]

# Calculate the average adjusted close prices
avg1 <- mean(df1)
avg2 <- mean(df2)

# Calculate the differences from average for both symbols
df1$AVGS1_S1 <- df1 - avg1
df2$AVGS2_S2 <- df2 - avg2

# Calculate squared differences and cross-products
df1$Average_SQ <- df1$AVGS1_S1^2
df1$AVG_AVG <- df1$AVGS1_S1 * df2$AVGS2_S2

# Calculate sum of squared differences and sum of cross-products
sum_sq <- sum(df1$Average_SQ, na.rm = TRUE)
sum_avg <- sum(df1$AVG_AVG, na.rm = TRUE)

# Compute slope and intercept for Linear Regression
slope <- sum_avg / sum_sq
intercept <- avg2 - (slope * avg1)

# Calculate Linear Regression line
df1$Linear_Regression <- intercept + slope * as.numeric(df1$AAPL.Adjusted)

# Create a ggplot chart for AAPL Closing Price
closing_price_chart <- ggplot(df1, aes(x = index(df1), y = AAPL.Adjusted)) +
  geom_line(color = "blue") +
  labs(title = "AAPL Adjusted Close Price",
       x = "Date",
       y = "Price") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Create a ggplot chart for Linear Regression line
regression_chart <- ggplot(df1, aes(x = index(df1), y = Linear_Regression)) +
  geom_line(color = "red", linetype = "dashed") +
  labs(title = "Linear Regression of AAPL",
       x = "Date",
       y = "Linear Regression Price") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, regression_chart, ncol = 1)