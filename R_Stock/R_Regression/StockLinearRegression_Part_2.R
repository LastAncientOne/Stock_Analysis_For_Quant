# Linear Regression Part 2

library(quantmod)
library(broom)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)
Stock$Date = as.Date(rownames(Stock))

x <- Stock$AAPL.Open
y <- Stock$AAPL.Adjusted


relationship <- lm(y~x)
print(relationship)

# Find Closing Price with Low Price of 180
a <- data.frame(x = 180)
result <- predict(relationship,a)
print(result)

# Plot Chart
plot(y,x, col = 'blue', main = "Low & Closing Price Regression", abline(lm(x~y)),cex=0.5, pch=16, xlab = 'Low Price', ylab = 'Adj Closing Price')

scatter.smooth(y, x, main='Adjusted close vs. Open')

boxplot(y, main="Adj Close Boxplot")


boxplot(x, main="Open Boxplot")

# Fit simple linear regression model
model <- lm(y~x)

# Print model summary
summary(model)

# Models performance
glance(model)

# Define residuals
res <- resid(model)

# Produce residual vs. fitted plot
plot(fitted(model), res)

# Add a horizontal line at 0 
abline(0,0)

# Create Q-Q plot for residuals
qqnorm(res)

# Add a straight diagonal line to the plot
qqline(res) 


