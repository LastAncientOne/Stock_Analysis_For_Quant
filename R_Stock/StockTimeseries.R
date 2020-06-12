library(quantmod)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2019-01-01', to='2020-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)
Stock$Date = as.Date(rownames(Stock))

Price = Stock$AAPL.Adjusted
print(Price)

x = Price

stock.timeseries <- ts(x, start = c(2019,1),frequency = 24*6)

print(stock.timeseries)

plot(stock.timeseries, main = 'Stock Price Daily')


monthly = to.monthly(AAPL)
monthly

Price = monthly$AAPL.Adjusted
print(Price)


stock_m.timeseries <- ts(Price, start = c(2019,1),frequency = 12)

print(stock_m.timeseries)

plot(stock_m.timeseries, main = 'Stock Price Monthly')