# Logistic Regression

library(quantmod)
library(modelr)
library(broom)

# Pull data from Yahoo finance 
getSymbols('AMD', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AMD
Stock = data.frame(AMD)
Stock$Date = as.Date(rownames(Stock))

Stock$Up_Down <- ifelse(Stock$AMD.Open - Stock$AMD.Adjusted >= 0, 0, 1)
#Stock$Up_down <- NULL # To remove a column in R set it to NULL
head(Stock)

model = glm(formula = Up_Down ~ AMD.Volume + AMD.Adjusted, data = Stock, family = binomial)

print(summary(model))

AIC(model)
BIC(model)

data.frame(
  R2 = rsquare(model, data = Stock),
  MAE = mae(model, data = Stock)
)

glance(model)
