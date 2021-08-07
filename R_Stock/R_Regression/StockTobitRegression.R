# Tobit Regression

library(quantmod)
library(VGAM)
library(modelr)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)
Stock$Date = as.Date(rownames(Stock))

Stock$Up_Down <- ifelse(Stock$AAPL.Open - Stock$AAPL.Adjusted >= 0, 0, 1)
PriceChange <- Stock$AAPL.Adjusted - Stock$AAPL.Open
Stock$Class <- ifelse(PriceChange > 0, "UP", "DOWN")

head(Stock)

tail(Stock)

model <- vglm(formula = AAPL.Adjusted ~ AAPL.Open + AAPL.High + AAPL.Low + AAPL.Volume, 
              family = tobit(Upper = max(Stock$AAPL.Adjusted )), data = Stock)

print(model)

data.frame(
  R2 = rsquare(model, data = Stock),
  RMSE = rmse(model, data = Stock),
  MAE = mae(model, data = Stock)
)

summary(model)
