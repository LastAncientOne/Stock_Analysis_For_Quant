# Support Vector Regression (SVR) Part 2
library(quantmod)
library(e1071)
library(modelr)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)
Stock$Date = as.Date(rownames(Stock))

head(Stock)

tail(Stock)

dim(Stock)

x <- 1:503
y <- Stock$AAPL.Adjusted

model <- svm(y~x, Stock)

data.frame(
  R2 = rsquare(model, data = Stock),
  RMSE = rmse(model, data = Stock),
  MAE = mae(model, data = Stock)
)

summary(model)

predictYsvm <- predict(model, Stock)
plot(y, pch=16)
title("svr")
points(x, predictYsvm, col = "blue", pch=4)
points(x, predictYsvm, col = "blue", type="l")


rmse <- function(error)
{
  sqrt(mean(error^2))
}

error <- model$residuals  
predictionRMSE <- rmse(error)

print(predictionRMSE)