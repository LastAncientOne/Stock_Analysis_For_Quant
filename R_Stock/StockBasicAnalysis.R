library(quantmod)
library(xts) 
library(ggplot2)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)
Stock$Date = as.Date(rownames(Stock))

Stock_Close = AAPL$AAPL.Adjusted

# 200-day Moving Average
plot(Stock_Close,type='l',xlab='Date',ylab='Close Prices',main='Daily Close Prices of Stock')
lines(SMA(Ad(AAPL), n = 200), col = "red")