read\_format\_wq\_data
================
Christoper Chan
17:22 27 March 2019

Introduction
============

to do: - Create a function that outputs a .csv - Create a function that combines all the csv and outputs a single csv

This notebook is a part 0 of the Devereux Slough time series project. I have created functions that assist in reading in and cleaning the csv as well as some light feature engineering.

I've chosen to use the library here because it's simplicity and consistency. Because I have seperate directories for notebooks and data I needed a way to navigate between them. While base R does offer this functionality, pathing is relative to the current working directory which changes based on where I created a document. here offers absolute pathing by setting up a root directory.

The data I collected from Devereux Slogh comes from 4 loggers, each collecting different types of information.

``` r
library(here)
library(tidyverse)
library(rowr)
```

``` r
make_md <- function(input_name, output_name) {
  # Moves the knitted md and supporting images from the notebooks dir to reports
  # dir.
  # 
  # Args:
  #   input_name: The name of the knitted md. Typically same as the Rmd title.
  #   output_name: A new name for the md in the reports dir.
  #
  # Output: A new md in the reports dir. 
  file.rename(from = here('notebooks', input_name), 
              to = here('reports', output_name))
  
  file.copy(from = list.files(pattern = '*files'), 
            to = here('reports'), recursive = TRUE)
}

make_md('read_format_wq_data.md', 'read_format_wq_data.md')
```

    ## [1] TRUE TRUE

Setting the working directory as data/. This gives me the flexibility to work with csvs at different stages of cleaning pipeline.

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
    cat('Reading file: ', file, '\n')
    combined_df <- cbind.fill(combined_df, temp, fill=NA)
  }
  return(combined_df)
}
```

Change this function to reference columns by names instead of indexes

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
  factors_to_convert <- sapply(df[,3:8], is.factor)
  df[,3:8][factors_to_convert] <- lapply(df[3:8][factors_to_convert], 
                                         function(x) as.numeric(as.character(x)))
  # df[3:8] <- lapply(df[3:8], as.numeric(x))
  # for (i in list(3:8)) {
  #   if (is.factor(df[, i] == TRUE)) {
  #     df[, i] <- as.numeric(levels(df[, i]))[df[, i]]
  #  }
  #}
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
  mutate(df, level_m = conv_factor*(df[,'depth_pressure'] - df[,'surface_pressure']))
}
```

create\_arima\_ready works on date subdirectories. Therefore I'll need a function that can parse multiple date subdirectories.

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

Correctly parses some of the data. Some of the data is missing, find the data, name correctly

``` r
whole_dir <- function(path) {
  csv <- list.files(path, full.names = TRUE)
  arima_ready_dir <- lapply(csv, create_arima_ready)
  return(arima_ready_dir)
}
```

Test: single dir

``` r
# test_path <- here('data', 'interim', '180212 Logger Data')
# test1 <- create_arima_ready(test_path)
# 
# str(test1)
# head(test1)
```

Test: all dir

``` r
test_dir <- here('data', 'processed')

test5 <- whole_dir(test_dir)
```
