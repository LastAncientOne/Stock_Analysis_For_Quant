# Logistic Regression Part 2

library(quantmod)
library(modelr)
library(broom)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)
Stock$Date = as.Date(rownames(Stock))

Stock$Up_Down <- ifelse(Stock$AAPL.Open - Stock$AAPL.Adjusted >= 0, 0, 1)
#Stock$Up_down <- NULL # To remove a column in R set it to NULL
PriceChange <- Stock$AAPL.Adjusted - Stock$AAPL.Open
Stock$Class <- ifelse(PriceChange > 0, "UP", "DOWN")

head(Stock)

model = glm(formula = Up_Down ~ AAPL.Open + AAPL.High + AAPL.Low + AAPL.Volume + AAPL.Adjusted, data = Stock, family = binomial)

print(summary(model))

AIC(model)
BIC(model)

data.frame(
  R2 = rsquare(model, data = Stock),
  MAE = mae(model, data = Stock)
)

glance(model)
