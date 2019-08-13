# https://stackoverflow.com/questions/20500706/saving-multiple-ggplots-from-ls-into-one-and-separate-files-in-r

source('R/util.R')


eda <- function(df) {
  # logging
  message('Creating figures')
  item_vis(df)
  sales_vis(df)
  sales_dist(df)
}


item_vis <- function(df) {
  item_vis <- ggplot(df, aes(Item_Type, Item_Visibility)) +
    geom_boxplot() +
    theme(axis.text.x = element_text(angle=90, vjust=0.8)) + 
    xlab('Item type') +
    ylab('Item visibility') + 
    ggtitle('Item visibility by item type')
  
  save_to_png(item_vis, 'fig/item_vis.png')
}


sales_vis <- function(df) {
  ggplot(df, aes(Item_Visibility, Item_Outlet_Sales, color = Item_Category)) + 
    geom_point(size = 0.75) +
    xlab('Item visibility') +
    ylab('Sales') + 
    ggtitle('Item sales vs visibility labeled by category')

  save_to_png(sale_vis, 'fig/sale_vis')
}


sales_dist <- function(df) {
  ggplot(data, aes(Item_Outlet_Sales)) + 
    geom_density(fill='#56B4E9') +
    ggtitle('Distribution of the sales')
  
  save_to_png(sales_dist, 'fig/sales_dist')
}


