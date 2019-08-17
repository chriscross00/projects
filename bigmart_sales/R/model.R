library(randomForest)


create_train_test_split <- function(data, size = 0.7) {
  set.seed(50)
  
  message('Splitting')
  logdebug('Splitting the df')
  train_ind <- sample(nrow(data), size = floor(size*nrow(data)))
  train <- as.data.frame(data[train_ind, ])
  test <- as.data.frame(data[-train_ind, ])
  train_test_data <- list(train=train, test=test)
  
  return(train_test_data)
}


optimal_rf <- function(train) {
  
  message('Finding optimal hyperparameters...')
  all_mtry <- tuneRF(train[, 2:12], train[, 13], ntreeTry = 250, stepFactor = 0.5)
  best_mtry <- all_mtry[which.min(all_mtry[, 2])]
  
  writeLines(c('tuneRF raw output (mtry | OOBError)', all_mtry),
             'docs/tuneRF_output.txt')
  
  message('Optimal parameter number is: ', best_mtry)
  return(best_mtry)
}


model_rf <- function(df, mtry) {
  rf_model <- randomForest(df[, 2:12], df[, 13], )
  return()
}

