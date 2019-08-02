import_data <- function(){
  train_exp <- 'data/raw/Train.csv'
  test_exp <- 'data/raw/Test.csv'
  
  if (!file.exists(train_exp)){
    print('Please download the data from https://www.kaggle.com/brijbhushannanda1979/bigmart-sales-data/downloads/bigmart-sales-data.zip/1')
  } else{
    train <- read.csv(train_exp)  
  }
  if (!file.exists(test_exp)){
    print('Please download the data from https://www.kaggle.com/brijbhushannanda1979/bigmart-sales-data/downloads/bigmart-sales-data.zip/1')
  } else{
    test <- read.csv(test_exp)  
  }
  proj_data <- list(train=train, test=test)
  return(proj_data)
}
