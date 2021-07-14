# Multiple Regression Part 2

library(quantmod)
library(GGally)
library(broom)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
# Stock = data.frame(AAPL)
# Stock$Date = as.Date(rownames(Stock))

input <- Stock[,c("AAPL.Adjusted","AAPL.Open","AAPL.Low","AAPL.High")]

model <- lm(AAPL.Adjusted ~ AAPL.Open + AAPL.High + AAPL.Low, data = input)

data <- Stock[,c("AAPL.Adjusted","AAPL.Open","AAPL.Low","AAPL.High")]

head(data)

pairs(data, pch = 18, col = "steelblue")

ggpairs(data)

model <- lm(AAPL.Adjusted ~ AAPL.Open + AAPL.High + AAPL.Low, data = data)

hist(residuals(model), col = "steelblue")

# Create fitted value vs residual plot
plot(fitted(model), residuals(model))

# Add horizontal line at 0
abline(h = 0, lty = 2)

summary(model)

# Models performance
glance(model)
