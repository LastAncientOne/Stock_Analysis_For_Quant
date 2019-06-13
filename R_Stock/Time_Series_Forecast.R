#loading packages
library(TSA)
library(forecast)
library(quantmod)

# Pull data from Yahoo finance 
stock <- getSymbols('AMD', src = 'yahoo', from='2012-01-01', to='2017-10-24')
##Raw data plot for Close prices
plot(Cl(AMD),type='l',xlab='Time',ylab='Close Prices',main='Daily Close Prices of Stock')
#create the stock as time series plot
close_stock = ts(Cl(AMD), start = 1, end = length(Cl(AMD)), frequency = 1)
#checking the statinority of data
adf.test(close_stock, alternative = "stationary")
##using box cox get to know the root transformation for the data
BoxCox.ar(close_stock)
# from the plot we got lambda as 0.5 so we'll use square root transformation
#transforming the data
d1=diff(close_stock, lag = 1)
d1 = d1[!is.na(d1)]
logd1=diff(log(close_stock), lag = 1)
logd1 = logd1[!is.na(logd1)]
sd1=diff(sqrt(close_stock), lag = 1)
sd1 = sd1[!is.na(sd1)]

#plotting the data
plot.ts(d1,xlab='Time',ylab='Difference',main='First Degree Differencing on Raw Data')
plot.ts(logd1,xlab='Time',ylab='Difference',main='First Degree Differencing on Logged Data')
plot.ts(sd1,xlab='Time',ylab='Difference',main='First Degree Differencing on Square-root Data')

#checking the stationarity of transformed data
adf.test(sd1, alternative = "stationary")

##plotting the acf and pacf plots
acf(sd1, main='Autocorrelation Function of the First Differences Square-root Data')
pacf(sd1, main='Partial Autocorrelation Function of the First Differences Square-root Data')
eacf(sd1)

#using auto arima model we are fitting the data
auto.arima(close_stock)
model1 = Arima(close_stock,order=c(1,1,4))
summary(model1)
plot(forecast(object = model1, h = 100, level = 99))

model2 = Arima(close_stock,order=c(0,1,0))
summary(model2)
plot(forecast(object = model2, h = 100, level = 99))

# from the above we got likeARIMA(0,1,0) is the best fit
rwalkfore = rwf(close_stock, h=100, drift = T, level = 99)
summary(rwalkfore)

#plotting the fore casted values
plot(rwalkfore, ylab = "Closing Price", xlab =  "Time")
plot(rstandard(model2), ylab='Standardized Residuals')
abline(h=0, col = 'red')
plot(rwalkfore$residuals)

##resudial analysis of the data
qqnorm(rstandard(model2))
qqline(rstandard(model2), col = 'red')
acf(rstandard(model2))
tsdiag(model2
       model1=lm(close_stock~time(close_stock))
       summary(rwalkfore$residuals)
       plot(rwalkfore$model)
       plot(rstandard(rwalkfore), ylab='Standardized Residuals',type='o')
       abline(h=0)
       acf(diff(log(oil.price)), ci.type='ma')
       
       plot(rwalkfore$residuals)
       abline(h=0)
       qqnorm(rwalkfore$residuals)
       qqline(rwalkfore$residuals)
       ad.test(rwalkfore$residuals)
       shapiro.test(rwalkfore$residuals)
       Box.test(as.numeric(rwalkfore$residuals),lag = 30, type = "Ljung-Box")
       decompose(close_stock)
       plot(rstandard(model))
       qqnorm(residuals(model))
       qqline(residuals(model))
       acf(residuals(model))
       tsdiag(model1)
       qqnorm(sd1)
       qqline(sd1)
       auto.arima(sd1)