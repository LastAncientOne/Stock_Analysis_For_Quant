# Multivariate Adaptive Regression Splines

library(quantmod)
library(dplyr)
library(ggplot2)   
library(earth)    
library(caret)    

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
df <- AAPL
df = data.frame(AAPL)

head(df)

# Create a tuning grid
hyper_grid <- expand.grid(degree = 1:3,
                          nprune = seq(2, 50, length.out = 10) %>%
                            floor())

# Fit MARS model using k-fold cross-validation
MARS_model <- train(
  x = subset(df, select = -c(AAPL.Adjusted, AAPL.Open)),
  y = df$AAPL.Adjusted,
  method = "earth",
  metric = "RMSE",
  trControl = trainControl(method = "cv", number = 10),
  tuneGrid = hyper_grid)

MARS_model$results %>%
  filter(nprune==MARS_model$bestTune$nprune, degree==MARS_model$bestTune$degree)

# Display RMSE by Terms and Degree
ggplot(MARS_model)

