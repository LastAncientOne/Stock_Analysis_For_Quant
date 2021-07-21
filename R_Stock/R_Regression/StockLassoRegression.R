# Lasso Regression

library(quantmod)
library(broom)
library(modelr)
library(glmnet)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)
Stock$Date = as.Date(rownames(Stock))

head(Stock)

tail(Stock)

x <- as.matrix(Stock[c(1:3,5)])
y <- Stock$AAPL.Adjusted

model <- cv.glmnet(x, y, alpha = 1)

print(model)

best_lambda <- model$lambda.min
best_lambda

glance(model)

plot(model, main='Lasso Regression') 

# Find coefficients of best model
best_model <- glmnet(x, y, alpha = 1, lambda = best_lambda)
coef(best_model)

# Use fitted best model to make predictions
y_predicted <- predict(best_model, s = best_lambda, newx = x)

# Find SST and SSE
sst <- sum((y - mean(y))^2)
sse <- sum((y_predicted - y)^2)

# Find R-Squared
R2 <- 1 - sse/sst
R2