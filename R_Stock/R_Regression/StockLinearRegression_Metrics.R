library(quantmod)
library(broom)

# Pull data from Yahoo finance 
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL
Stock = data.frame(AAPL)
Stock$Date = as.Date(rownames(Stock))

x <- Stock$AAPL.Open
y <- Stock$AAPL.Adjusted

# Fit linear regression model
relationship <- lm(y~x)
print(relationship)

# Function to calculate regression metrics
calculate_metrics <- function(actual, predicted) {
  # Mean Squared Error
  mse <- mean((actual - predicted)^2)
  
  # Mean Absolute Error
  mae <- mean(abs(actual - predicted))
  
  # Root Mean Squared Error
  rmse <- sqrt(mse)
  
  # R-Squared
  ss_tot <- sum((actual - mean(actual))^2)
  ss_res <- sum((actual - predicted)^2)
  r_squared <- 1 - (ss_res / ss_tot)
  
  # Return metrics as a list
  return(list(
    MSE = mse,
    MAE = mae,
    RMSE = rmse,
    R_squared = r_squared
  ))
}

# Generate predictions
predictions <- predict(relationship)

# Calculate and display metrics
metrics <- calculate_metrics(y, predictions)
cat("\nRegression Metrics:\n")
cat("MSE:", metrics$MSE, "\n")
cat("MAE:", metrics$MAE, "\n")
cat("RMSE:", metrics$RMSE, "\n")
cat("R-squared:", metrics$R_squared, "\n")

# Find Closing Price with Low Price of 180
a <- data.frame(x = 180)
result <- predict(relationship,a)
print(result)

# Visualization
par(mfrow=c(2,2))

# Plot 1: Scatter plot with regression line
plot(y, x, col = 'blue', 
     main = "Low & Closing Price Regression",
     cex=0.5, pch=16, 
     xlab = 'Low Price', 
     ylab = 'Adj Closing Price')
abline(lm(x~y))

# Plot 2: Smooth scatter plot
scatter.smooth(y, x, main='Adjusted close vs. Open')

# Plot 3: Residual plot
res <- resid(relationship)
plot(fitted(relationship), res,
     main="Residual Plot",
     xlab="Fitted values",
     ylab="Residuals")
abline(h=0, col="red", lty=2)

# Plot 4: Q-Q plot
qqnorm(res)
qqline(res)

# Reset plotting layout
par(mfrow=c(1,1))

# Model summary and performance
summary(relationship)
glance(relationship)
