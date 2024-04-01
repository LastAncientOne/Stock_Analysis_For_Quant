# Huber Regression

library(quantmod)
library(MASS)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)
Stock$Date = as.Date(rownames(Stock))

# Assign independent and dependent variables
x <- Stock$AAPL.Open
y <- Stock$AAPL.Adjusted

# Perform Huber regression
huber_model <- rlm(y ~ x, method = "M")

# Summary of the model
summary(huber_model)

# Plot the data and regression line
plot(x, y, main = "Huber Regression", xlab = "AAPL Open", ylab = "AAPL Adjusted", col = "blue")
abline(huber_model, col = "red", lwd = 2)