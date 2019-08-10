# Steps
# 1. Split data 70-30
# 2. Make model
# 3. Validate model

library(randomForest)


create_train_test_split <- function(data, size = 0.7) {
  set.seed(50)
  
  train_ind <- sample(nrow(data), size = floor(size*nrow(data)))
  train <- data[train_ind, ]
  test <- data[-train_ind, ]
  train_test_data <- list(train=train, test=test)
  
  message('Splitting ')
  return(train_test_data)
}


optimal_rf <- function(train) {
  set.seed(50)
  
  all_mtry <- tuneRF(train[, 1:12], train[, 13])
  best_mtry <- arrayInd(which.min(all_mtry[, 2]), dim(all_try))
  
  message(best_mtry)
  print('please work')
  return(best_mtry)
}
