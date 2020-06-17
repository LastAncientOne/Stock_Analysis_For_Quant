library(quantmod)
library(xts) 

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)

head(Stock)

tail(Stock)

price = round(Stock$AAPL.Adjusted, digits=2)

sort(price)

# find minimum (lowest) price
min(price)

# find maximum (highest) price
max(price)

# find median price
median(price)

quantile(price)

quantile(price, 0.25)

quantile(price, 0.75)

# find 25th, 50th and 75th quartile,
quantile(price, c(0.25, 0.5, 0.75))


# min, Q1, median, Q3, max
fivenum(price)

summary(price)

# Plot Box Price
par(mfrow = c(1, 2))
boxplot(price, main = 'Horzonital Boxplot of Stock Price')
boxplot(price)
abline(h = min(price), col = "Blue")
abline(h = max(price), col = "Yellow")
abline(h = median( price), col = "Green")
abline(h = quantile(price, c(0.25, 0.75)), col = "Red")


par(mfrow = c(2, 1))
boxplot(price, horizontal=TRUE, main = 'Vertical Boxplot of Stock Price')
boxplot(price, horizontal=TRUE)
abline(v = min(price), col = "Blue")
abline(v = max(price), col = "Yellow")
abline(v = median( price), col = "Green")
abline(v = quantile(price, c(0.25, 0.75)), col = "Red")



par(mfrow = c(1, 1))
boxplot(price, horizontal = TRUE, axes = FALSE, staplewex = 1, main = 'Horzonital Boxplot Summary')
text(x=fivenum(price), labels =fivenum(price), y=1.25)


par(mfrow = c(1, 1))
boxplot(price, axes = FALSE, staplewex = 1, main = 'Vertical Boxplot Summary')
text(y = boxplot.stats(price)$stats, labels = boxplot.stats(price)$stats, x = 1.25)