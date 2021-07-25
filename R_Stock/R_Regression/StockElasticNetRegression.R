# Elastic Net Regression 

library(quantmod)
library(ensr)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)
Stock$Date = as.Date(rownames(Stock))

head(Stock)

tail(Stock)

x <- as.matrix(Stock[c(1:3)])
y <- as.matrix(Stock$AAPL.Adjusted)


model <- ensr(y = y, x = x, standardize = FALSE)

print(model)

summary(model)