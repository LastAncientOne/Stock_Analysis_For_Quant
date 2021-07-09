library(quantmod)
library(xts) 
library(ggplot2)
library(magrittr) # load %>%
library(dplyr) # load %>%

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)
Stock$Date = as.Date(rownames(Stock))

direction <- NULL
direction[Stock$AAPL.Adjusted < rbind(Stock$AAPL.Adjusted, 1)] <- 1
direction[Stock$AAPL.Adjusted > rbind(Stock$AAPL.Adjusted, 1)] <- 0

input = Stock[,c('AAPL.Open','AAPL.High','AAPL.Low','AAPL.Volume')]

lr <- glm(formula = Stock$AAPL.Adjusted ~ Stock$AAPL.Open + Stock$AAPL.High + Stock$AAPL.Low + Stock$AAPL.Volume, data=input, family=binomial)

# Find Closing Price with Low Price of 180
print(summary(lr))

# lag() function similar to shift() in python
lag(Stock,k=1)

# Create Column
Stock$Up_Down <- 0

Stock$Up_Down <- ifelse(lag(Stock$AAPL.Adjusted,k=0) > Stock$AAPL.Adjusted,1,0)


Stock$Up_Down <- ifelse(shift(Stock$AAPL.Adjusted,n=-1) > Stock$AAPL.Adjusted,1,0)

Stock$Up_Down <- ifelse(head(Stock$AAPL.Adjusted,-1) > Stock$AAPL.Adjusted,1,0)

https://www.datanovia.com/en/lessons/subset-data-frame-rows-in-r/
Stock %>% filter(
  Stock$AAPL.Adjusted > lag(Stock$AAPL.Adjusted,k=1), 
  Up_Down == 1 | Up_Down == 0)