# Partial least regression (PCR)
library(quantmod)
library(pls)
library(modelr)
library(broom)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)
Stock$Date = as.Date(rownames(Stock))

Stock$Up_Down <- ifelse(Stock$AAPL.Open - Stock$AAPL.Adjusted >= 0, 0, 1)
PriceChange <- Stock$AAPL.Adjusted - Stock$AAPL.Open
Stock$Class <- ifelse(PriceChange > 0, "UP", "DOWN")


model = plsr(Class~., data = Stock, scale = TRUE, validation = "CV")
# contrasts can be applied only to factors with 2 or more levels


print(model)

summary(model)

validationplot(model)
validationplot(model, val.type="MSEP")
validationplot(model, val.type="R2")