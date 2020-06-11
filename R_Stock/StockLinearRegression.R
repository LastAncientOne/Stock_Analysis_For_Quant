library(quantmod)
library(xts) 
library(ggplot2)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)
Stock$Date = as.Date(rownames(Stock))

x <- Stock$AAPL.Open
y <- Stock$AAPL.Adjusted


relationship <- lm(y~x)
print(relationship)

# Find Closing Price with Low Price of 180
a <- data.frame(x = 180)
result <- predict(relationship,a)
print(result)

# Plot Chart
plot(y,x, col = 'blue', main = "Low & Closing Price Regression", abline(lm(x~y)),cex=0.5, pch=16, xlab = 'Low Price', ylab = 'Adj Closing Price')

