# Stepwise Regression

library(quantmod)
library(leaps)
library(MASS)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)

head(Stock)

tail(Stock)

model <- regsubsets(AAPL.Adjusted ~., data = Stock, nvmax = 5,
                        method = "seqrep")

print(model)

summary(model)

