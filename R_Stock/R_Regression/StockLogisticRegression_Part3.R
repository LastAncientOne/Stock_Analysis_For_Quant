# Load required libraries
library(quantmod)
library(broom)
library(ggplot2)
library(tidyverse)
library(lubridate)

# Function to perform stock regression analysis
analyze_stock_regression <- function(ticker, start_date, end_date) {
  # Fetch stock data
  getSymbols(ticker, from = start_date, to = end_date, adjust = TRUE)
  stock_data <- get(ticker)
  
  # Convert to data frame and add date column
  stock_df <- data.frame(stock_data)
  stock_df$Date <- as.Date(rownames(stock_df))
  
  # Create necessary columns
  colnames(stock_df) <- gsub(paste0(ticker, "."), "", colnames(stock_df))
  
  # Calculate daily returns
  stock_df$DailyReturn <- c(NA, diff(log(stock_df$Adjusted)))
  
  # Create lagged features
  stock_df$PrevDayReturn <- lag(stock_df$DailyReturn)
  stock_df$Volume_Scaled <- scale(stock_df$Volume)
  stock_df$PriceRange <- (stock_df$High - stock_df$Low) / stock_df$Open
  
  # Remove NA values
  stock_df <- na.omit(stock_df)
  
  # Fit multiple regression model
  model <- lm(DailyReturn ~ PrevDayReturn + Volume_Scaled + PriceRange, data = stock_df)
  
  # Get model summary statistics
  model_summary <- summary(model)
  model_metrics <- glance(model)
  
  # Create predictions
  stock_df$Predicted <- predict(model, stock_df)
  
  # Calculate prediction error
  stock_df$Error <- stock_df$DailyReturn - stock_df$Predicted
  
  # Create visualizations
  actual_vs_predicted <- ggplot(stock_df, aes(x = DailyReturn, y = Predicted)) +
    geom_point(alpha = 0.5) +
    geom_abline(intercept = 0, slope = 1, color = "red", linetype = "dashed") +
    labs(title = paste("Actual vs Predicted Returns -", ticker),
         x = "Actual Returns",
         y = "Predicted Returns") +
    theme_minimal()
  
  residuals_plot <- ggplot(stock_df, aes(x = Date, y = Error)) +
    geom_line() +
    geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
    labs(title = paste("Residuals Over Time -", ticker),
         x = "Date",
         y = "Prediction Error") +
    theme_minimal()
  
  # Return results as a list
  return(list(
    model = model,
    summary = model_summary,
    metrics = model_metrics,
    data = stock_df,
    plots = list(
      actual_vs_predicted = actual_vs_predicted,
      residuals = residuals_plot
    )
  ))
}

# Example usage
results <- analyze_stock_regression(
  ticker = "AAPL",
  start_date = "2016-01-01",
  end_date = "2018-01-01"
)

# Print model summary
print(results$summary)

# Print model metrics
print(results$metrics)

# Display plots
print(results$plots$actual_vs_predicted)
print(results$plots$residuals)

# Example of how to make predictions for new data
predict_returns <- function(model, new_data) {
  predictions <- predict(model, newdata = new_data)
  return(predictions)
}