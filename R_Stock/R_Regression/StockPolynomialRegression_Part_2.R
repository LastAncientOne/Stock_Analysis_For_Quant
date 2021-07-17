# Polynomial Regression Part 2

library(quantmod)
library(broom)
library(ggplot2)  

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
df <- AAPL
df = data.frame(AAPL)

df$Date = as.Date(rownames(df))

df$Date <- as.numeric(df$Date) 

head(df)

tail(df)

nrow(df)

ggplot(df, aes(x=Date, y=AAPL.Adjusted)) +
  geom_point()

# df[1:5] <- list(NULL)

# Create Polynomial Model
model = lm(AAPL.Adjusted ~ poly(Date,2, raw=T), data=df)

# Summary of model
summary(model)

glance(model)

ggplot(df, aes(x=Date, y=AAPL.Adjusted)) + 
  geom_point() +
  stat_smooth(method='lm', formula = y ~ poly(x,2), size = 1) + 
  xlab('Date to Numbers') +
  ylab('Adj Closed')+
  ggtitle("Polynomial Regression") +
  theme(plot.title = element_text(hjust = 0.5))