library(randomForest)
library(MLmetrics)
library(modelr)


create_train_test_split <- function(data, size = 0.7) {
  set.seed(50)
  
  message('Splitting')
  #logdebug('Splitting the df')
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


model_rf <- function(train) {
  
  message('Creating a random forest model...')
  rf_model <- randomForest(train[, 2:12], train[, 13], mtry = 3, ntree=5, importance=T)
  
  return(rf_model)
}


predict_rf <- function(test, model) {
  
  loginfo('Predicting values')
  
  pred <- predict(model, newdata = test[, 2:12])
  score <- MSE(pred, test[, 13])
  
  return(score)
}

