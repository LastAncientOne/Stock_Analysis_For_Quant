# Basic Stock Analysis in R

library(quantmod)
library(magrittr) # need to run every time you start R and want to use %>%
library(dplyr)

getSymbols('AAPL',from="2016-01-01",to="2018-12-28")

head(AAPL)

tail(AAPL)

plot(AAPL$AAPL.Adjusted)

AAPL_log_returns <- AAPL%>%Ad()%>%dailyReturn(type='log')

plot(AAPL_log_returns)

summary(AAPL)

AAPL.delFirst<-AAPL[-1,] # delete first row
head(AAPL.delFirst)

AAPL.onlyFirst<-AAPL[1,] # Firsst rows of data
AAPL.onlyFirst

AAPL[c(1,nrow(AAPL)),] # First and last rows

# Technical Analysis 
AAPL%>%Ad()%>%chartSeries()

AAPL%>%chartSeries(TA='addBBands();addVo();addMACD()',subset='2018')


# Convert Daily to Weekly
wk<-AAPL
weekly<-to.weekly(wk)
weekly[c(1:3,nrow(weekly)),]


# Convert Daily to Monthly
mo<-AAPL
monthly<-to.monthly(mo)
monthly[c(1:3,nrow(monthly)),]

# Average
mean(AAPL_log_returns)

# Volatility 
sd(AAPL_log_returns)

# Normality Test - Shapiro-Wilk test
shapiro.test(as.vector(AAPL_log_returns))

# T-Test for a One-Time Series
t.test(AAPL_log_returns, mu=0)

# Simple Moving Average
n <- 20
SMA <- rollapply(AAPL$AAPL.Adjusted, width = n,
                        FUN = mean, by.column = TRUE,
                        fill = NA, align = "right")


# Moving Average Convergence Divergence Oscillator (MACD)
n1 <- 12
n2 <- 26
MACD <- rollapply(AAPL$AAPL.Adjusted, width = n2,
            FUN = function(v) mean(v[(n2 - n1 + 1):n2]) - mean(v),
            by.column = TRUE, fill = NA, align = "right")


# Bollinger Bands
n <- 20
BB <- rollapply(AAPL$AAPL.Adjusted, width = n,
                FUN = sd, by.column = TRUE,
                fill = NA, align = "right")
upperseries <- meanseries + 2 * BB
lowerseries <- meanseries + 2 - BB


