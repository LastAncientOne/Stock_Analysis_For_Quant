# Polynomial Regression

library(quantmod)
library(ggplot2)  
library(broom)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
df <- AAPL
df = data.frame(AAPL)

head(df)

tail(df)

nrow(df)

# Example
model <- lm(AAPL.Adjusted~ poly(AAPL.Open, 5, raw = TRUE), 
            data = df)

glance(model)

predictions <- model %>% predict(df)
# Model performance
modelPerfomance = data.frame(
  RMSE = RMSE(predictions, df$AAPL.Adjusted),
  R2 = R2(predictions, df$AAPL.Adjusted)
)

print(lm(AAPL.Adjusted ~ AAPL.Open + I(AAPL.Open^2), data = df))
print(modelPerfomance)

ggplot(df, aes(AAPL.Open, AAPL.Adjusted) ) + geom_point() + 
  stat_smooth(method = lm, formula = y ~ poly(x, 5, raw = TRUE))