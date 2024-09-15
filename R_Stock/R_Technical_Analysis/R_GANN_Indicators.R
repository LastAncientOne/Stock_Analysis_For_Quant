library(quantmod)
library(ggplot2)
library(dplyr)
library(tidyverse)

getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Define Gann Angles
angles <- c(82.5, 75, 71.25, 63.75, 45, 26.25, 18.75, 15, 7.5)

# Function to calculate Gann Angles
calculate_gann_line <- function(start_date, start_price, angle, data, price_col = "Adjusted") {
  # Convert angle to radians
  angle_rad <- angle * pi / 180
  # Calculate slope based on angle
  slope <- tan(angle_rad)
  
  # Calculate end date and end price based on the slope
  end_date <- index(data)[nrow(data)]
  end_price <- start_price + (slope * as.numeric(difftime(end_date, start_date, units = "days")))
  
  # Create a data frame for the angle line
  angle_line <- data.frame(
    Date = c(start_date, end_date),
    Price = c(start_price, end_price)
  )
  
  return(angle_line)
}

# Define start date and price
start_date <- index(Stock)[1]
start_price <- as.numeric(Stock$AAPL.Adjusted[1])

# Create a base plot with closing prices
p <- ggplot() +
  geom_line(data = as.data.frame(Stock), aes(x = index(Stock), y = AAPL.Adjusted), color = "blue") +
  labs(title = "Gann Angles and Closing Price",
       x = "Date",
       y = "Price") +
  theme_minimal()

# Add Gann Angles to the plot
for (angle in angles) {
  gann_line <- calculate_gann_line(start_date, start_price, angle, Stock)
  p <- p + geom_line(data = gann_line, aes(x = Date, y = Price), color = "red", linetype = "dashed")
}

# Print the plot
print(p)