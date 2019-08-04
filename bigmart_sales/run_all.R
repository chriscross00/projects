# read
# https://stackoverflow.com/questions/36699272/why-is-message-a-better-choice-than-print-in-r-for-writing-a-package/36700294

library(tidyverse)

source('R/import.R')
source('R/clean_data.R')

work <- import_data()

train <- work$train
test <- work$test

train_clean <- clean_data(train)
head(train)
head(train_clean)
