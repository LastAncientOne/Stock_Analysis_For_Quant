# Simple Analysis Charts
library(quantmod)
library(xts) 
library(ggplot2)

# Pull data from Yahoo finance 
getSymbols('AAPL', src="yahoo", from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)
Stock$Date = as.Date(rownames(Stock))

colnames(Stock)[6] = 'Price'

#Plot for Close prices
plot(Stock_Close,type='l',xlab='Date',ylab='Close Prices',main='Daily Close Prices of Stock')


# 200-day Moving Average
plot(Stock_Close,type='l',xlab='Date',ylab='Close Prices',main='Daily Close Prices of Stock')
lines(SMA(Ad(AAPL), n = 200), col = "red")

# Beautiful Plot
ggplot(data=Stock_Close, aes(x=date, y=Ad(AAPL))) + geom_line() + theme_bw()

ggplot(data=Stock,aes(x=date, y=Price)) +
  geom_line() + labs(x = 'Date', y = 'Closing\nPrice', title = "Daily Close Prices of Stock") 
