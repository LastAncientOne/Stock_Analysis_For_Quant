# Sharpe Ratio
library(quantmod)
library(xts) 
library(randtests)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2018-01-01', to='2020-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)

head(Stock)

tail(Stock)

price = round(Stock$AAPL.Adjusted, digits=2)

stock_ret <- 100*diff(log(price))

# Convert to numeric
ret_price = as.numeric(stock_ret)

rf = 0.001
mu = mean(ret_price)
sigma = sd(ret_price)


sharpe_ratio = (mu - rf) / sigma
print(paste('Sharpe Ratio: ', sharpe_ratio))

sharpe_ratio_trading = ((mu - rf) / sigma) * sqrt(252)
print(paste('Sharpe Ratio in trading: ', sharpe_ratio_trading))