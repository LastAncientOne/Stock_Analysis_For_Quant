# Stepwise Regression Part 2

library(quantmod)
library(MASS)
library(modelr)
library(broom)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)

head(Stock)

tail(Stock)

full.model <- lm(AAPL.Adjusted ~ .,data = Stock)

step.model <- stepAIC(full.model, direction = "both", 
                      trace = FALSE)

print(step.model)

data.frame(
  R2 = rsquare(step.model, data = Stock),
  RMSE = rmse(step.model, data = Stock),
  MAE = mae(step.model, data = Stock)
)

summary(step.model)

glance(step.model)
