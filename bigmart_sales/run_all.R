# read
# https://stackoverflow.com/questions/36699272/why-is-message-a-better-choice-than-print-in-r-for-writing-a-package/36700294

library(tidyverse)

source('R/import.R')
source('R/clean_data.R')
source('R/eda.R')
source('R/model.R')

main <- function() {
  work <- import_data()
  
  train <- work$train
  test <- work$test
  
  train_clean <- clean_data(train, 'data/interim/train_clean.csv')
  
  train_test_data <- create_train_test_split(train_clean)

  train_split <- train_test_data$train
  test_split <- train_test_data$test

  a_test <- optimal_rf(train_split)
}

main()
