# read
# https://stackoverflow.com/questions/13733552/logger-configuration-to-log-to-file-and-print-to-stdout
# figure out why variables aren't being logged

library(tidyverse)
library(logging)

source('R/import.R')
source('R/clean_data.R')
source('R/eda.R')
source('R/model.R')

configure_logging <- function() {
  basicConfig()
  
  addHandler(writeToFile, file = 'log/bigmart.log', level = 'INFO')
  loginfo('Initializing logger')
}


main <- function() {
  configure_logging()
  
  work <- import_data()
  
  train <- work$train
  test <- work$test
  
  train_clean <- clean_data(train, 'data/interim/train_clean.csv')
  
  train_test_data <- create_train_test_split(train_clean)
  
  train_split <- train_test_data$train
  test_split <- train_test_data$test
  
  
}

main()
