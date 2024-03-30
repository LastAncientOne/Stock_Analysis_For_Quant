# Ridge Regression

library(quantmod)
library(modelr)
library(broom)
library(glmnet)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)
Stock$Date = as.Date(rownames(Stock))

# independent variable belongs on the x-axis (horizontal line) of the graph 
# dependent variable belongs on the y-axis (vertical line) of the graph
# X - Independent Variable
# Y - Dependent Variable
x <- Stock$AAPL.Open
y <- Stock$AAPL.Adjusted

model <- glmnet(x, y, alpha = 0)
summary(model)

AIC(model)
BIC(model)

data.frame(
  R2 = rsquare(model, data = Stock),
  RMSE = rmse(model, data = Stock),
  MAE = mae(model, data = Stock)
)

glance(model)
