stackFinancials <-
  function(symbols, type = c("BS", "IS", "CF"), period = c("A", "Q")) {
    # Ensure the type and period arguments match viewFinancials
    type <- match.arg(toupper(type[1]), c("BS", "IS", "CF"))
    period <- match.arg(toupper(period[1]), c("A", "Q"))
    
    # Simple function to get financials for one symbol
    getOne <- function(symbol, type, period) {
      gf <- getFinancials(symbol, auto.assign = FALSE)
      vf <- viewFinancials(gf, type = type, period = period)
      # Put viewFinancials output into a data.frame
      df <- data.frame(vf, line.item = rownames(vf), type = type,
                       period = period, symbol = symbol,
                       stringsAsFactors = FALSE, check.names = FALSE)
      # Reshape data.frame into long format
      long <- reshape(df, direction="long", varying=seq(ncol(vf)),
                      v.names="value", idvar="line.item",
                      times=colnames(vf))
      # Reset row.names to "automatic"
      rownames(long) <- NULL
      # Return data
      long
    }
    # Loop over all symbols
    allData <- lapply(symbols, getOne, type = type, period = period)
    # rbind() all into one data.frame
    do.call(rbind, allData)
  }



library(quantmod)
Data <- stackFinancials(c("GE", "AAPL"), type = "IS", period = "Q")
head(Data, 4)



extractLineItem <- function(stackedFinancials, line.item) {
  if (missing(stackedFinancials) || missing(line.item)) {
    stop("You must provide output from stackFinancials(),",
         "and the line.item to extract")
  }
  # Select line items matching user input
  match.rows <- grepl(line.item, Data$line.item, ignore.case = TRUE)
  sfSubset <- Data[match.rows,]
  getItem <- function(x) {
    # Create xts object
    output <- xts(x$value, as.yearmon(x$time))
    # Ensure column names are syntactically valid
    valid.names <- make.names(paste(x$symbol[1], x$line.item[1]))
    # Remove repeating periods
    colnames(output) <- gsub("\\.+", "\\.", valid.names)
    output
  }
  # Split subset by line.item and symbol
  symbol.item <- split(sfSubset, sfSubset[, c("symbol", "line.item")])
  # Apply getItem() to each chunk, and merge into one object
  do.call(merge, lapply(symbol.item, getItem))
}



totalRevenue <- extractLineItem(Data, "total revenue")
totalRevenue



plot(totalRevenue, main = "Quarterly Total Revenue, AAPL (black) vs GE (red)")



operatingIncome <- extractLineItem(Data, "operating income")
operatingIncome 



plot(operatingIncome / totalRevenue, main = "Quarterly Operating Margin, AAPL (black) vs GE (red)")

