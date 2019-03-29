library(quantmod)

# Get stock data
start <- as.Date('2018-01-01')
end <- as.Date('2018-12-31')
getSymbols('AAPL', src="yahoo", from = start, to = end)

head(AAPL)

AAPL$Returns <- c(-diff(AAPL$AAPL.Adjusted)/AAPL$AAPL.Adjusted[-1] *  100)

na.omit(AAPL) # Drop NaNs

wins = AAPL$Returns[AAPL$Returns > 0]
losses = AAPL$Returns[AAPL$Returns <= 0]

W = length(wins) / length(AAPL$Returns)

R = array(mean(wins)) / abs(array(mean(losses)))

Kelly = W - ( (1 - W) / R )

print(paste0('Kelly Criterion: ', round(Kelly, digits = 2)))
cat('Kelly Criterion: ', round(Kelly, digits = 2))