# Bayesian Linear Regression

library(quantmod)
library(rstanarm)
library(bayestestR)
library(bayesplot)
library(insight)
library(broom)
library(modelr)


# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)
Stock$Date = as.Date(rownames(Stock))

head(Stock)

tail(Stock)

model <- stan_glm(AAPL.Adjusted ~., data = Stock)

print(model) 

posteriors <- describe_posterior(model)
# for a nicer table
print_md(posteriors, digits = 2)

describe_posterior(model)

eti(model)

rope(model)

rope_range(model)
