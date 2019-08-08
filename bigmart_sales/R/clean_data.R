# https://stackoverflow.com/questions/12048436/r-sourcing-files-using-a-relative-path?noredirect=1&lq=1

source('R/util.R')


clean_data <- function(data, path) {
  # This pipeline modifies columns in the dataframe from left to right
  
  data <- data %>%
    separate(Item_Identifier, c('Item_Category', 'Item_Identifier'), sep=2)
  data$Item_Category = as.factor(data$Item_Category)
  
  data <- data %>%
    group_by(Item_Type) %>%
    mutate(Item_Weight = impute_mean(Item_Weight))
  
  data <- data %>%
    mutate(Item_Fat_Content = replace(
      Item_Fat_Content, Item_Fat_Content == 'LF', 'Low Fat')) %>%
    mutate(Item_Fat_Content = replace(
            Item_Fat_Content, Item_Fat_Content == 'low fat', 'Low Fat')) %>%
    mutate(Item_Fat_Content = replace(
      Item_Fat_Content, Item_Fat_Content == 'reg', 'Regular')) %>%
    droplevels()
  
  data <- data %>%
    mutate(Years_Open = 2013 - Outlet_Establishment_Year) %>%
    mutate(Outlet_Size = replace(Outlet_Size, Outlet_Size == '' & 
                                   Outlet_Location_Type == 'Tier 2', 'Small')) %>%
    mutate(Outlet_Size = replace(Outlet_Size, Outlet_Size == '' & 
                                   Outlet_Location_Type == 'Tier 3', 'Medium'))
  data <- data[, c(1,2,3,4,5,6,7,14,8,10,11,12,13)]
  
  save_to_csv(data, path)
  
  return(data)
}


impute_mean <- function(grouped_var) {
  replace(grouped_var, is.na(grouped_var), mean(grouped_var, na.rm=T))
}

