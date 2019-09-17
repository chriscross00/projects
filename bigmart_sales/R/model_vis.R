# rewrite this chunk. use built in $importance

create_feat_imp_df <- function(model){
  feat_imp <- model %>%
    importance(type=1) %>%
    as.tibble() %>%
    rename(Inc_MSE= '%IncMSE') %>%
    mutate(Feature = rownames(importance(store_rf))) %>%
    select(Feature, Inc_MSE) %>%
    mutate(relative_imp = Inc_MSE/sum(Inc_MSE)) %>%
    mutate(Feature = factor(Feature, levels=Feature[order(Inc_MSE)])) 
}


test <- function(model){
  
}

# ggplot(feat_imp, aes(Feature, relative_imp)) +
#   geom_bar(stat='identity', fill='#56B4E9') +
#   coord_flip() +
#   ylab('Relative importance') +
#   ggtitle('Relative importance of features from Random Forest model')