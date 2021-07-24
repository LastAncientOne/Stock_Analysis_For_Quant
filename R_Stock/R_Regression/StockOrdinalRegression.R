# Ordinal Regression

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

qr <- glm(AAPL.Adjusted ~ ., data = Stock, family = poisson)

print(qr)

glance(qr)

data.frame(
  R2 = rsquare(qr, data = Stock),
  RMSE = rmse(qr, data = Stock),
  MAE = mae(qr, data = Stock)
)

summary(qr)

plot(AAPL.Adjusted ~ AAPL.Open , data = Stock, pch = 16, main = "Plot")
abline(lm(AAPL.Adjusted ~ AAPL.Open , data = Stock), col = "red", lty = 2)
abline(rq(AAPL.Adjusted ~ AAPL.Open , data = Stock), col = "blue", lty = 2)