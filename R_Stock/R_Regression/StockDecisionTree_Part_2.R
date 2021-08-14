# Decision Tree Regression Part 2
# Categorical Variable Variable Decision Tree 

library(quantmod)
library(rpart)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)
Stock$Date = as.Date(rownames(Stock))

Stock$Up_Down <- ifelse(Stock$AAPL.Open - Stock$AAPL.Adjusted >= 0, 0, 1)
PriceChange <- Stock$AAPL.Adjusted - Stock$AAPL.Open
Stock$Class <- ifelse(PriceChange > 0, "UP", "DOWN")

x <- as.matrix(Stock[c(1:3,5)])
y <- Stock$Class

model <- rpart(y ~ x, 
             method = "class", data = Stock )

summary(model)

plot(model, uniform = TRUE,
     main = "Stock Decision Tree using Regression")
text(model, use.n = TRUE, cex = .6)

print(model)