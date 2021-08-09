# Tobit Regression Part 2

library(quantmod)
library(AER)
library(broom)

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

model <- tobit(AAPL.Adjusted ~ AAPL.Open + AAPL.Volume,
              data = Stock)

print(model)

summary(model)

AIC(model)
BIC(model)

glance(model)