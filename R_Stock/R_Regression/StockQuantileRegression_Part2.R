# Multiple Regression

library(quantmod)
library(xts) 
library(ggplot2)
library(broom)
library(quantreg)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
# Stock = data.frame(AAPL)
# Stock$Date = as.Date(rownames(Stock))

input <- Stock[,c("AAPL.Adjusted","AAPL.Open","AAPL.Low","AAPL.High")]

model <- rq(AAPL.Adjusted ~ AAPL.Open + AAPL.High + AAPL.Low, data = input, tau = c(0.1, 0.5, 0.9))

print(model)

# View the summary of the model
summary(model)

# Plot each chart
plot(model)
abline(coef(model)[1], coef(model)[2], col = "red")

# Plot all 4
layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
plot(model)
