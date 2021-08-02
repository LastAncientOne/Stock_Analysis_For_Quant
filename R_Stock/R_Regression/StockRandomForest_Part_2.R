# Random Forest Part 2

library(quantmod)
library(modelr)
library(broom)
library(randomForest)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)
Stock$Date = as.Date(rownames(Stock))

head(Stock)

tail(Stock)

rf <- randomForest(AAPL.Adjusted ~ ., data = Stock, importance = TRUE,
                   proximity = TRUE)

print(rf)

plot(rf, main="Random Forest")

data.frame(
  R2 = rsquare(rf, data = Stock),
  RMSE = rmse(rf, data = Stock),
  MAE = mae(rf, data = Stock)
)