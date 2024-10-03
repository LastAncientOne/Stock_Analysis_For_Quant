library(quantmod)
library(ggplot2)
library(gridExtra)
library(zoo)  # For rollapply function

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Define the number of periods for the moving averages
n <- 10
m <- 10

# Calculate the Moving Average High and Low with a rolling window
Stock$MA_High <- rollapply(Stock$AAPL.High, width = n, FUN = mean, align = 'right', fill = NA)
Stock$MA_Low <- rollapply(Stock$AAPL.Low, width = m, FUN = mean, align = 'right', fill = NA)

# Create a ggplot chart combining all data with legends
combined_chart <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = AAPL.Close, color = 'Closing Price')) +
  geom_line(aes(y = MA_High, color = 'Moving Average High'), linetype = 'dashed') +
  geom_line(aes(y = MA_Low, color = 'Moving Average Low'), linetype = 'dotted') +
  labs(title = "AAPL Stock Prices with Moving Averages",
       x = "Date",
       y = "Price") +
  scale_color_manual(values = c('Closing Price' = 'black', 'Moving Average High' = 'red', 'Moving Average Low' = 'green')) +
  theme(plot.title = element_text(hjust = 0.5)) +  # Center the plot title
  theme(legend.title = element_blank())  # Remove the legend title

# Display the combined chart
print(combined_chart)