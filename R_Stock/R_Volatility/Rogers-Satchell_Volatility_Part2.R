# Load the required library
library(quantmod)

# Individual symbol
symbol <- "AAPL"

# Set the start and end date of the analysis
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Get the historical data
getSymbols(symbol, from = start_date, to = end_date)
data <- get(symbol)

# Calculate daily High-Low (HL), High-Close (HC), and Low-Close (LC) differentials
HC <- Hi(data) - Cl(data)
HO <- Hi(data) - Op(data)
LC <- Lo(data) - Cl(data)
LO <- Lo(data) - Op(data)

# Calculate the sum of squares of these differentials
sum_diff <- sum((HO*HC) + (LO*LC))

# Calculate the Rogers-Satchell Volatility
n <- nrow(data)
RS_volatility <- sqrt(1/n) * sqrt(sum_diff)

RS_volatility