read\_format\_wq\_data
================
Christoper Chan
March 19, 2019

``` r
library(here)
library(tidyverse)
library(rowr)
```

Setting the working dir

``` r
here()
```

    ## [1] "/home/ckc/Documents/git_projects/projects/devereux_arima"

Skip=1 is required because each csv has a Plot\_title as the first row. I need to cbind, not make a single csv I'll need to modify this when I read all the dir. This reads date subdir individually.

``` r
create_date_df <- function(path) {
  # Recursively reads csv files and binds them to each other column-wise
  #
  # Args:
  #   path(object): A specified directory to read
  #
  # Returns:
  #   combined_df(dataframe): A dataframe with all csv's columns appended
  my_files <- 
    list.files(path,
               pattern = '*.csv',
               full.names = TRUE,
               recursive = TRUE) 
  combined_df <- data.frame()
  
  for (file in my_files){
    temp <- read_csv(file, skip=1)
    combined_df <- cbind.fill(combined_df, temp, fill=NA)
  }
  return(combined_df)
}
```

``` r
clean_date_df <- function(df) {
  # Removes duplicate columns from dataframe, shortens names and changes factors 
  # to numeric when appropriate
  #
  # Args:
  #   df(dataframe): A dataframe with duplicate indexes and times
  #
  # Returns:
  #   df(dataframe): A cleaned dataframe ready for feature engineering
  df <- df[c(2:5, 8, 9, 12, 13)]
  names(df) <- c('obs', 'date_time', 'surface_pressure', 'air_temp1', 'salinity', 
                 'sal_temp2', 'depth_pressure', 'depth_temp')
  df <- drop_na(df)
  
  # Converts factors to doubles 
  for (i in list(3, 4, 7, 8)){
    df[, i] <- as.numeric(levels(df[, i]))[df[, i]]
  }
  return(df)
}
```

``` r
create_level <- function(df) {
  # Creates the water level in meters, converting the difference of air pressure
  # and depth pressure
  #
  # Args:
  #   df(dataframe): A dataframe with duplicate indexes and times
  #
  # Returns:
  #   df(dataframe): A dataframe ready for a ARIMA model
  conv_factor = 0.013595100263597
  mutate(df, level_m = conv_factor*(df[, 7] - df[, 3]))
}
```

Test run

``` r
create_arima_ready <- function(path) {
  # A helper function that wraps the creation and cleaning of a dataframe
  #
  # Args:
  #   path(object): A specified directory to read
  #
  # Returns:
  #   ready_df(dataframe): A dataframe ready for a ARIMA model
  ready_df <- path %>%
    create_date_df() %>%
    clean_date_df() %>%
    create_level()
  
  return(ready_df)
}
```

Okay, so i need to label each output CSV. I can do this by parsing the name of each input.

``` r
test_path <- 'working_data/180530 Logger Data/'
test1 <- create_arima_ready(test_path)

head(test1)
```

    ##    obs            date_time surface_pressure air_temp1 salinity sal_temp2
    ## 1    1 05/19/18 02:00:00 PM           759.70    17.665  31.2050     24.39
    ## 2    2 05/19/18 02:15:00 PM           759.61    17.950  31.1553     24.49
    ## 3    3 05/19/18 02:30:00 PM           759.56    17.855  31.2430     24.69
    ## 4    4 05/19/18 02:45:00 PM           759.40    17.760  31.2167     24.79
    ## 5    5 05/19/18 03:00:00 PM           759.21    17.855  31.2607     24.92
    ## 6    6 05/19/18 03:15:00 PM           759.04    17.760  31.2372     25.02
    ##   depth_pressure depth_temp  level_m
    ## 1         904.03     19.853 1.962181
    ## 2         903.91     19.853 1.961773
    ## 3         903.82     19.948 1.961229
    ## 4         903.61     20.043 1.960549
    ## 5         903.61     20.043 1.963132
    ## 6         903.45     19.948 1.963268

``` r
write_csv(test1, path = 'test12345.csv')
```

Correctly parses some of the data. Some of the data is missing, find the data, name correctly

``` r
whole_dir <- function(path) {
  csv <- list.files(path, full.names = TRUE)
  arima_ready_dir <- lapply(csv, create_arima_ready)
  return(arima_ready_dir)
}
```
