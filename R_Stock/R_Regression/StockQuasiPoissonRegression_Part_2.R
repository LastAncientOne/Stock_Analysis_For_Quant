# quasi-Poisson Regression Part 2

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

x <- as.matrix(Stock[c(1:3)])
y <- as.matrix(Stock$AAPL.Adjusted)


model <- glm(y ~ x, quasipoisson)

print(model)

summary(model)

model$coefficients

AIC(model)
BIC(model)

data.frame(
  R2 = rsquare(model, data = Stock),
  MAE = mae(model, data = Stock)
)

glance(model)