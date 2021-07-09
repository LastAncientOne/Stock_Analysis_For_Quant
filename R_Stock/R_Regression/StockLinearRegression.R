library(quantmod)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)
Stock$Date = as.Date(rownames(Stock))

x <- Stock$AAPL.Open
y <- Stock$AAPL.Adjusted


relationship <- lm(y~x)
print(relationship)
