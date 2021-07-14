# Linear Regression

library(quantmod)
library(modelr)
library(broom)

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

# Linear regression attempts to model the relationship between two variables 
# by fitting a linear equation to observed data
relationship <- lm(y~x)
print(relationship)

AIC(relationship)
BIC(relationship)

data.frame(
  R2 = rsquare(relationship, data = Stock),
  RMSE = rmse(relationship, data = Stock),
  MAE = mae(relationship, data = Stock)
)

glance(relationship)