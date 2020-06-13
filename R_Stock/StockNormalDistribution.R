library(quantmod)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2019-01-01', to='2020-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)
Stock$Date = as.Date(rownames(Stock))

Price = Stock$AAPL.Adjusted
print(Price)

x = Price
mean = mean(x)
sd = sd(x)

y <- dnorm(x, mean, sd) 

# probability distribution
plot(x,y)


y <- pnorm(x, mean, sd) 
plot(x, y)

y <- rnorm(x, mean, sd) 
plot(x, y)

hist(y, main='Normal Distribution')