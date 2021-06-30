library(quantmod)

# Create new environment
data_env <- new.env()
# Use getSymbols to load data into the environment
getSymbols(c("INTC", "AMD"), from = "2021-01-01", to = "2021-06-01", env = data_env, auto.assign = TRUE)

# Extract volume column from each object
adjusted_list <- lapply(data_env, Ad)
# Merge each list element into one object
stocks_list <- do.call(merge, adjusted_list)
head(stocks_list)

stock_change = diff(log(stocks_list))[-1,]
head(stock_change)

var.test(stock_change$AMD.Adjusted, stock_change$INTC.Adjusted)
