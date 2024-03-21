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

# Calculate the daily returns
returns <- dailyReturn(data$AAPL.Close)

# Calculate the squared returns
squared_returns <- returns^2

# Define the window size for the rolling volatility calculation
window_size <- 20  # You can adjust this based on your preference

# Calculate the rolling volatility using Rogers-Satchell method
rogers_satchell_volatility <- sqrt(rollapply(squared_returns, window_size, mean, align = "right"))

# Print the Rogers-Satchell Volatility 
cat("Rogers-Satchell Volatility :", rogers_satchell_volatility)

