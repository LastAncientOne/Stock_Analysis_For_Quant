# Neural Network Regression

library(quantmod)
library(neuralnet)

# Assign independent and dependent variables
x <- Stock$AAPL.Open
y <- Stock$AAPL.Adjusted

# Normalize data (optional but recommended for neural networks)
x_norm <- scale(x)
y_norm <- scale(y)

# Create a data frame with normalized variables
data <- data.frame(x = x_norm, y = y_norm)

# Train neural network
set.seed(123)  # for reproducibility
nn <- neuralnet(y ~ x, data, hidden = 5)  # you can adjust the number of hidden neurons

# Plot the neural network
plot(nn)

# Predict using the trained model
predicted <- predict(nn, data)

# Denormalize the predictions
predicted_denorm <- predicted * sd(y) + mean(y)

# Plot predicted vs actual
plot(Stock$Date, y, type = "l", col = "blue", xlab = "Date", ylab = "Adjusted Price", main = "Neural Network Regression")
lines(Stock$Date, predicted_denorm, col = "red")
legend("topleft", legend = c("Actual", "Predicted"), col = c("blue", "red"), lty = 1)