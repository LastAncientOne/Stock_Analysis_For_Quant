library(quantmod)
library(forecast)
library(tseries)

# Pull data from Yahoo finance 
stock <- getSymbols('AMD', src = 'yahoo', from='2012-01-01', to='2017-10-24')

Stock_Close <- Ad(AMD)

##Raw data plot for Close prices
plot(Stock_Close,type='l',xlab='Time',ylab='Close Prices',main='Daily Close Prices of Stock')

# Check is Seasonal
TS <- ts(Stock_Close)
fit <- tbats(TS)
seasonal <- !is.null(fit$seasonal)
seasonal


# Convert Data to Stationay
# ADF:
# Null Hypothesis: Data is NOT stationary.
# Alt Hypothesis: Data is stationary.
# ADF test gives a p-value greater > than .05, so we cannot reject null hypothesis. Therefore, our data is not stationary.
adf.test(TS, alternative = c("stationary"))

# KPSS:
# Null Hypothesis: Data is stationary.
# Alt Hypothesis: Data is NOT stationary.
# KPSS test gives a p-value<.05, so we can reject null hypothesis. Therefore, our data is not stationary.
kpss.test(TS, null = c("Level", "Trend"), lshort = TRUE)



# Difference the data by the order of 1.
diff1 <- diff(Stock_Close, differences=1)
plot(diff1)

# p <.05, so I can reject null hypothesis therefore data is stationary.
diff1 <- diff(TS)
adf.test(diff1, alternative = c("stationary"))

# p>.05, so I cannot reject null hypothesis therefore data is stationary.
kpss.test(diff1, null = c("Level", "Trend"), lshort = TRUE)


# With one order of differencing, I achieved stationarity in the data. Therefore, in arima(p,d,q)x(P,D,Q) model, d=1.
# Autocorrelation Function (ACF) and Partial Autocorrelation Function (PACF) to find the p and q. 
Acf(coredata(diff1), main="ACF plot of differenced data")

Pacf(coredata(diff1), main="PACF plot of differenced data")
# There are no significant peaks in either ACF or PACF plots at 1st, 2nd or 3rd lags. Therefore, I will pick p=0 and q=0.
# Therefore, our final model is arima(0,1,0)


fit <- arima(TS, order=c(0,1,0))
summary(fit)

AcF(coredata(fit$residuals), main="ACF plot of Residuals")

Pacf(coredata(fit$residuals), main="PACF plot of Residuals")

library(lmtest)
coeftest(fit)

fit <- arima(TS, order=c(0,1,3), seasonal=c(1,0,1))
summary(fit)

fit1 <- arima(TS)
summary(fit1)

accuracy(fit)

accuracy(fit2)



# Build an ARIMA Model
# Check the RMSE values
Train <- TS[1:1306,]
Test <- TS[1307:1336,]
fit <- auto.arima(Train)
summary(fit)

pred <- data.frame(forecast(fit, h=30))
pred_points <- pred$Point.Forecast
sqrt(mean(pred_points-Test)^2)

# More data points
Train <- TS[1:1067,]
Test <- TS[1068:1336,]
fit <- auto.arima(Train)
summary(fit)

pred <- data.frame(forecast(fit, h=269))
pred_points <- pred$Point.Forecast
sqrt(mean(pred_points-Test)^2)

