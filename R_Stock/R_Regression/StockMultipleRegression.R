library(quantmod)
library(xts) 
library(ggplot2)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
# Stock = data.frame(AAPL)
# Stock$Date = as.Date(rownames(Stock))

input <- Stock[,c("AAPL.Adjusted","AAPL.Open","AAPL.Low","AAPL.High")]

model <- lm(AAPL.Adjusted ~ AAPL.Open + AAPL.High + AAPL.Low, data = input)

print(model)


cat("# # # # The Coeficient Values # # #","\n")
b <- coef(model)[1]
print(b)
x1 <- coef(model)[2]
x2 <- coef(model)[3]
x3 <- coef(model)[4]
print(x1)
print(x2)
print(x3)

# Other useful functions
coefficients(model) # model coefficients
confint(model, level=0.95) # CIs for model parameters
fitted(model) # predicted values
residuals(model) # residuals
anova(model) # anova table
vcov(model) # covariance matrix for model parameters
influence(model) # regression model


# Plot each chart
plot(model)

# Plot all 4
layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
plot(model)
