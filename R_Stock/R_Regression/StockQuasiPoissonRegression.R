# Quasi Poisson Regression

library(quantmod)
library(modelr)
library(broom)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)
Stock$Date = as.Date(rownames(Stock))

head(Stock)

tail(Stock)

x <- Stock$AAPL.Open
y <- Stock$AAPL.Adjusted

model <- glm(y~x, Stock, family=quasipoisson)

data.frame(
  R2 = rsquare(model, data = Stock),
  RMSE = rmse(model, data = Stock),
  MAE = mae(model, data = Stock)
)

AIC(model)
BIC(model)

glance(model)

summary(model)
