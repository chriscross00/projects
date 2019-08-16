import_data <- function() {
  
  train_exp <- 'data/raw/Train.csv'
  loginfo('Attemping import from ', train_exp)
  test_exp <- 'data/raw/Test.csv'
  loginfo('Attemping import from ', test_exp)
  tryCatch(
    {
      train <- read.csv(train_exp)
      test <- read.csv(test_exp)
      proj_data <- list(train=train, test=test)
      
      message('Reading in the data')
      return(proj_data)
    },
    error = function(error){
      message('Please download the data from https://www.kaggle.com/brijbhushannanda1979/bigmart-sales-data/downloads/bigmart-sales-data.zip/1')
      message(error)
    }
  )
}
