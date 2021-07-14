# Multiple Regression Part 3

library(quantmod)
library(reshape)
library(tidyverse)
library(modelr)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
df <- AAPL
# Stock = data.frame(AAPL)
# Stock$Date = as.Date(rownames(Stock))

df = data.frame(AAPL)

df$Date = as.Date(rownames(df))

df$Date <- as.numeric(df$Date)


head(df)

dt <- data.frame(
  id = df$Date,
  open = rnorm(df$AAPL.Open, mean = mean(df$AAPL.Open), sd = sd(df$AAPL.Open)), 
  high = rnorm(df$AAPL.High, mean = mean(df$AAPL.High), sd = sd(df$AAPL.High)), 
  low = rnorm(df$AAPL.Open, mean = mean(df$AAPL.Open), sd = sd(df$AAPL.Low)), 
  close = rnorm(df$AAPL.Close, mean = mean(df$AAPL.Close), sd = sd(df$AAPL.Close)),
  volume = rnorm(df$AAPL.Volume, mean = mean(df$AAPL.Volume), sd = sd(df$AAPL.Volume)),
  adjclose = rnorm(df$AAPL.Adjusted, mean = mean(df$AAPL.Adjusted), sd = sd(df$AAPL.Adjusted))
)
dt %>% 
  slice(1:5)

long = melt(dt, id.vars = c("id" ,"adjclose", "open", "high", "low", "volume"))
long %>% 
  slice(1:5)

long %>% 
  group_by(variable) %>% 
  do(tidy(lm(adjclose ~ value + open + high + low + volume, .))) %>% 
  filter(term == "value") %>% 
  mutate(Beta = as.character(round(estimate, 3)), "P Value" = round(p.value, 3), SE = round(std.error, 3)) %>% 
  select(Beta, SE, "P Value") %>% 
  as.data.frame()
