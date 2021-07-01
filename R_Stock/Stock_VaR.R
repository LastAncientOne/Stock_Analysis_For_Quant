# Value at Risk

library(quantmod)

symbol <- "AMD"

start <- "2020-01-01"
end <- "2021-06-30"

amd <- getSymbols(symbol, from = start, to = end, auto.assign = F)

head(amd)

r <- diff(log(amd$AMD.Adjusted))[-1,]

m <- mean(r)

s <- sd(r)

VaR <- -qnorm(0.05, m, s)

sprintf("Value-at-Risk: %f", VaR)

sprintf("The VaR (95 percent, 1 day) is %f.  It has 95 percent probability that %s shares will not lose 
        or lose more than %f in one day", VaR, symbol, VaR)