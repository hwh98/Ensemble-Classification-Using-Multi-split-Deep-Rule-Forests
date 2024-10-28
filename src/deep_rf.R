# deep rule forest 
# case : `mincase` to constraint growth of C50.
deep_rf <- function(train_df, test_df, y, parameter_list, layer, seed = 1234){
  train_temp = train_df 
  test_temp = test_df
  layer_rf = list() # list to record the random forest in each layer
  layer_trainacc = list()  # record the train_acc each layer
  layer_testacc = list()
  
  for(deep_l in c(1:layer)){
    cat('###Level', deep_l, '###\n')
    cat('# of tree : ', parameter_list[[deep_l]]$ntree, ', mincase:',parameter_list[[deep_l]]$min_case, ', column ratio', parameter_list[[deep_l]]$mtry_ratio,'\n')
    
    # rule forest 
    rf_model = rule_forest(train_df = train_temp, test_df = test_temp, target_y = y,
                            n_tree = parameter_list[[deep_l]]$ntree, mincase = parameter_list[[deep_l]]$min_case, 
                           layer = paste0('L', deep_l,"."), mtry = parameter_list[[deep_l]]$mtry_ratio * (length(colnames(train_temp)) - 1),
                           seed = seed) 
    
    # record layer-wised info
    layer_rf = append(layer_rf, list(rf_model)) # record deep_l layer RF
    acc = vote_acc(train_d, rf_model$train_pred, test_d, rf_model$test_pred, y)
    layer_trainacc = append(unlist(layer_trainacc), acc$train) # layer-wised acc
    layer_testacc = append(unlist(layer_testacc), acc$test)
    
    # update df for next layer 
    train_temp = data.frame(rf_model$train_encodingdf, target = train_d[[y]])
    test_temp = data.frame(rf_model$test_encodingdf, target = test_d[[y]])
    names(train_temp)[names(train_temp) == 'target']  = y
    names(test_temp)[names(test_temp) == 'target']  = y
    
    # add level that's in test df but not in train df 
    for(m in colnames(train_temp)){
      if(m==y){
        union_level = levels(train_df[[y]]) # reorder the factor level of `y` 
      }
      else{
        union_level = union(unique(test_temp[[m]]), unique(train_temp[[m]]))
      }
      train_temp[[m]] = factor(train_temp[[m]], levels = union_level)
      test_temp[[m]] = factor(test_temp[[m]], levels = union_level)
    }
    
  }
  plot_accline(layer_trainacc, layer_testacc, tree = layer, title ='layer-wised performance on poker')
  
  return(list('layer_rf' = layer_rf, 'train_layeracc' = layer_trainacc, 'test_layeracc' = layer_testacc)) # return RF of each layer 
}
