# Poisson Regression

library(quantmod)
library(broom)
library(modelr)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)
Stock$Date = as.Date(rownames(Stock))

head(Stock)

tail(Stock)

pr <- glm(AAPL.Adjusted ~ ., data = Stock, family = poisson)

print(pr)

glance(pr)

data.frame(
  R2 = rsquare(pr, data = Stock),
  RMSE = rmse(pr, data = Stock),
  MAE = mae(pr, data = Stock)
)