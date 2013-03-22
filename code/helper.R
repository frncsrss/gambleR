# ratio between true positives and predicted as positive
precision <- function(actuals, predictions, class=NULL) {
  if(is.null(class)) {
    return(sum(predictions == actuals, na.rm=TRUE) / sum(predictions, na.rm=TRUE))    
  }
  return(sum(predictions == actuals & predictions == class, na.rm=TRUE)
         / sum(predictions == class, na.rm=TRUE))
}

# ratio between true positives and actual positives
recall <- function(actuals, predictions, class=NULL) {
  if(is.null(class)) {
    return(sum(predictions == actuals, na.rm=TRUE) / sum(actuals, na.rm=TRUE))
  }
  return(sum(predictions == actuals & predictions == class, na.rm=TRUE)
         / sum(actuals == class, na.rm=TRUE))
}

# harmonic mean (constant numerator) between precision and recall
fmeasure <- function(actuals, predictions, class=NULL) {
  P <- precision(actuals, predictions, class)
  R <- recall(actuals, predictions, class)
  return(2 * P * R / (P + R))
}

# precision/recall ROCR performance object
precision.recall.perf <- function(predictions, actuals) {
  library(ROCR)
  return(performance(prediction(predictions, actuals), "rec", "prec"))
}

# precision/recall curve csv file - one point per line
precision.recall.file <- function(predictions, actuals, filename) {
  perf <- precision.recall.perf(predictions, actuals)
  df <- unique(data.frame(precision=perf@x.values, recall=perf@y.values))
  names(df) <- c("precision", "recall")
  write.csv(df, file=filename, row.names=FALSE)
}
