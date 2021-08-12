# Decision Tree Regression
#	Continuous Variable Decision Tree 

library(quantmod)
library(modelr)
library(rpart)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)
Stock$Date = as.Date(rownames(Stock))

x <- as.matrix(Stock[c(1:3,5)])
y <- Stock$AAPL.Adjusted

model <- rpart(x ~ y, 
             method = "anova", data = Stock )

summary(model)

data.frame(
  R2 = rsquare(model, data = Stock),
  RMSE = rmse(model, data = Stock),
  MAE = mae(model, data = Stock)
)

plot(model, uniform = TRUE,
     main = "Stock Decision Tree using Regression")
text(model, use.n = TRUE, cex = .6)

print(model)
