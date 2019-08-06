# Steps
# 1. Split data 70-30
# 2. Make model
# 3. Validate model

create_train_test_split <- function(data, size = 0.7) {
  set.seed(50)
  
  train_ind <- sample(nrow(data), size = floor(size*nrow(data)))
  train <- data[train_ind, ]
  test <- data[-train_ind, ]
  train_test_data <- list(train=train, test=test)
  
  return(train_test_data)
}


