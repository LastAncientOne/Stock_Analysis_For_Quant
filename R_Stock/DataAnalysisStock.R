library(quantmod)

# Get stock data
start <- as.Date('2018-01-01')
end <- as.Date('2018-12-31')
getSymbols('AAPL', src="yahoo", from = start, to = end)

# Get stock information
class(AAPL)

head(AAPL)
tail(AAPL)
View(AAPL)
price = na.omit(AAPL[, "AAPL.Adjusted"])
plot(price, main='Stock Closing Prices')
summary(AAPL)

# Plot stock time series for Closing Prices
plot(AAPL$AAPL.Adjusted, main="AAPL Closing Prices")

# Plot stock candlechart
chartSeries(AAPL$AAPL.Adjusted)
chartSeries(AAPL)
candleChart(AAPL,theme='white', type='candles') 

# Parametric ES - Normality Assumption
stock.price <- na.omit(AAPL[, "AAPL.Adjusted"])
stock.returns <- periodReturn(stock.price, period='daily', type='log')
stock.mean <- mean(stock.returns)
stock.variance <- var(stock.var)
horizon <- 1
confidence <- qnorm(0.05)
stock.VaR.p <- -(stock.mean*horizon+confidence*
                   sqrt(horizon*stock.variance))
stock.ES.p <- -(stock.mean*horizon - sqrt(horizon*stock.variance)
                /(1-0.95)*exp(-0.5*confidence^2)/sqrt(2*pi))


# Non-Parametric ES - Model-Free
stock.returns.sorted <- sort(stock.returns)
stock.VaR.np <- -stock.returns.sorted[round(0.05*dim(stock.returns)[1]),]
stock.ES.np <- -mean(stock.returns.sorted[1:round(0.05*dim(stock.returns)[1]),])
ES(stock.returns, p=0.95, method="historical")

# Non-Parametric VaR - Model-Free
stock.returns.sorted <- sort(stock.returns)
stock.VaR.np <- -stock.returns.sorted[round(0.05*dim(stock.returns)[1]),]
stock.VaR.np

# Comparision
stock.VaR.p
stock.VaR.np
VaR(stock.returns, 0.95, method=c("GaussianVaR"))
VaR(stock.returns, 0.95, method=c("HistoricalVaR"))

# Plot Chart
chart.VaRSensitivity(stock.returns], 
                     methods=c("HistoricalVaR", "ModifiedVaR", "GaussianVaR"),
                     reference.grid=TRUE, xlab= "Confidence Level", ylab="Value at Risk",
                     type="l", colorset=bluefocus, lwd=2, lty=c(1,2,4), colorset =(1:12), pch=(2:12))

# VaR quantile
ret.var <- quantile(stock.returns, c(0.05,0.01,0.001))
ret.var

# Estimate Probability of returns that will fall below a specific threshold
# Cumulative distribution function (CDF)
# Estimate returns will be negative
pnorm(q=0, mean=mean(stock.returns), sd=sd(stock.returns),lower.tail=TRUE)
# Estimate returns will be positive
pnorm(q=0, mean=mean(stock.returns), sd=sd(stock.returns),lower.tail=FALSE)

# Estimate the probabilities for negative and positive returns equal to 1
prob.below.0 <- pnorm(q=0, mean=mean(stock.returns), sd=sd(stock.returns),lower.tail=TRUE)
prob.above.0 <- pnorm(q=0, mean=mean(stock.returns), sd=sd(stock.returns),lower.tail=FALSE)
sum(prob.below.0, prob.above.0)

# Drawdowns
library(PerformanceAnalytics)
table.Drawdowns(stock.returns, top=3)

# Plot Drawdowns
library(timeSeries)
stock.dd <- drawdowns(timeSeries(stock.returns))
plot(stock.dd*100, type='l', main='Stock Drawdowns', ylab='Drawdown Percent(%)')

# Annualized Volatility
round(StdDev.annualized(stock.returns), 5)

# Sharpe Ratio
round(SharpeRatio.annualized(stock.returns, Rf=0.01/12),3)

# Sortino Ratio
round(SortinoRatio(stock.returns), 3)

# Stock Statistics Analysis
summary(stock.returns)

# Exploratory Factor Analysis
EFA <- factanal(stock.returns, factors = 1)
EFA

# Principal component portfolios
PCA.rets <- prcomp(stock.returns)
print(summary(PCA.rets), digits=3)

# Kurtosis
kurtosis(stock.returns)

# Cumulative Returns
plot(cumprod(1+stock.returns), type = 'l', main='Stock Simulated Prices')

# Value at Risk
library(MASS)

fit.norm <- fitdistr(stock.returns, "normal")
alpha <- 0.05
mu <- fit.norm$estimate[1]
sigma <- fit.norm$estimate[2]
VaR.norm <- (mu + sigma * qnorm(alpha))
VaR.norm

# Value at Risk with t-distribution
fit.t <- fitdistr(stock.returns*100, "t")
sigma <- fit.t$estimate[2]/100
nu <- fit.t$estimate[3] 
VaR.t <- sigma * qt(df=nu, p=0.05)
VaR.t

# Plot Value-at-Risk
hist(stock.returns, breaks=50, freq=FALSE, main='Distribution of Stock Returns')
abline(v=VaR.norm, lwd=2, lty=1)
abline(v=VaR.t, lwd=2, lty=3)
legend("topleft", legend = c("VaR.norm","VaR.t"), col="black", lty=c(1,2))
box()

# Plot Chart Bar of Value-at-Risk
chart.BarVaR(stock.returns, legend.loc='topleft', methods = c("HistoricalES"),
             main="Stock Returns and ES", lty = c(2), legend.cex = 0.8, width=12)

# QQ Plot
qqnorm(stock.returns); qqline(stock.returns)

# skewness and kurtosis
library(moments)
skewness(stock.returns)
kurtosis(stock.returns)

# Shapiro-Wilks test
shapiro.test(as.numeric(stock.returns))

# Kolmogorov-Smirnov test
ks.test(stock.returns,"pnorm",mean(stock.returns),sqrt(var(stock.returns)))

# Anderson-Darling test
library(nortest)
ad.test(stock.returns)
