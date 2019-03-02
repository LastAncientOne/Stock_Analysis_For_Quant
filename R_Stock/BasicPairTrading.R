library(quantmod)

stock1 <- "AMD"
stock2 <- "INTC"

getSymbols(stock1, src = "yahoo")
getSymbols(stock2, src = "yahoo")


stock1 <- AMD
stock2 <- INTC

head(AMD)
head(INTC)

stock1 <- stock1[, grep("Adjusted", colnames(stock1))]
stock2 <- stock2[, grep("Adjusted", colnames(stock2))]

start_off_date <- as.Date("2016-01-01")
stock1 <- stock1[index(stock1) >= start_off_date]
stock2 <- stock2[index(stock2) >= start_off_date]

stock1.returns <- periodReturn(stock1, period='daily', type='log')
stock2.returns <- periodReturn(stock2, period='daily', type='log')


stock1.returns <- round(stock1.returns+1, 4)
stock1.returns[1] <- 1
norm_stock1 <- cumprod(stock1.returns)
plot(stock1.returns, main = "AMD Returns")

stock2.returns <- round(stock2.returns+1, 4)
stock2.returns[1] <- 1
norm_stock2 <- cumprod(stock2.returns)
plot(stock2.returns, main = "Intel Returns")


plot_final <- plot(norm_stock1, type = "l", ylim = c(0, 7), ylab = "Normalized_Price", main='Stock Pair Trading')
lines(norm_stock1, col = "red")
lines(norm_stock2, col = "blue")
legend("topleft", c(colnames(stock1)[1], colnames(stock2)[1]), lty = 1, col = c("red", "blue"), bty = "o", cex = 1)
