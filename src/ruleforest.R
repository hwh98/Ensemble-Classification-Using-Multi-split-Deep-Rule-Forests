# bagging C50 
rule_forest <- function(train_df, test_df, target_y, n_tree, mincase, mtry, layer, seed = 1234){
  # layer : setting column name of df below with layer name ('L1.T23', 'L3.T12')
  # mtry : # of column for training one C50 tree.
  
  # initialize j-depth df and list
  encode_traindf = data.frame(matrix(nrow = nrow(train_df), ncol = n_tree, dimnames = list(rownames(train_df), paste0(layer, 'T', c(1:n_tree))))) # df for encode through out tree 
  encode_testdf = data.frame(matrix(nrow = nrow(test_df), ncol = n_tree, dimnames = list(rownames(test_df), paste0(layer, 'T', c(1:n_tree)))))
  train_pred = data.frame(matrix(nrow = nrow(train_df), ncol = n_tree, dimnames = list(rownames(train_df), paste0(layer, 'T', c(1:n_tree))))) # df for pred through out tree
  test_pred = data.frame(matrix(nrow = nrow(test_df), ncol = n_tree, dimnames = list(rownames(test_df), paste0(layer, 'T', c(1:n_tree)))))
  l_model = list()
  l_rule = list()
  l_modparty = list()
  l_testacc = list()
  l_trainacc = list()
  null_tree = c() # record the NULL, which is tree without any splitting and may happend at first layer.
  
  # Random forest 
  for(i in c(1:n_tree)){ 
    # column sampling on both train & test
    colsample_df = columnsample(train_df, test_df, target_y, num_col = mtry, seed = seed + i)
    # row sampling on training only 
    boostrap_train <<- rowsample(colsample_df$train, seed = seed+i, imb = F, y = target_y)
    
    # C50 model 
    registerDoMC(10)
    set.seed(seed)
    model = C5.0(formula = hand ~ ., data = boostrap_train,
                 control = C5.0Control(noGlobalPruning = F,
                                       minCases = mincase)
    )
    registerDoSEQ()
    
    # region encode 
    modparty <- validate.as.party.C5.0(model)
    rule = extractRules.rbC5.0(modparty)
    cat(i, 'tree with', length(rule),'rules')
    # record model and prediction
    l_rule = append(l_rule, list(rule))
    l_model = append(l_model, list(model))
    l_modparty = append(l_modparty, list(modparty))
    
    # deal with tree without any splitting
    if(length(rule) > 1 ){ # only encode when there is rule (skip when model no rule no splitting point)
      region_encoding = rule_encoding(rule, colsample_df$train, colsample_df$test, target_y) # return its matched rule
      encode_traindf[, i] = region_encoding$training$region
      encode_testdf[, i] = region_encoding$testing$region  
      # single C50 train acc
      pred = predict(model, colsample_df$train %>% select(-target_y))
      train_pred[, i]= pred
      l_trainacc = append(unlist(l_trainacc), acc_df(pred, colsample_df$train[[target_y]]))
      cat(" | single train acc ", acc_df(pred, colsample_df$train[[target_y]]))
      # single C50 test acc
      pred = predict(model, colsample_df$test %>% select(-target_y))
      test_pred[, i] = pred
      l_testacc = append(unlist(l_testacc), acc_df(pred, colsample_df$test[[target_y]]))
      cat(" | test acc ", acc_df(pred, colsample_df$test[[target_y]]),'\n')
    }
    else{ # record NULL tree 
      null_tree = c(null_tree,i)
      cat(' | remove tree\n')
    }
    
  }
  if(length(null_tree) > 0){
    # remove the NULL tree from df 
    cat('null tree: ', null_tree, '\n')
    encode_traindf = encode_traindf[-null_tree]
    encode_testdf = encode_testdf[-null_tree]
    train_pred = train_pred[-null_tree]
    test_pred = test_pred[-null_tree]
  }
  
  return(list('model' = l_model, 'rule' = l_rule, 'party' = l_modparty,
              'train_encodingdf' = data.frame(encode_traindf), 'test_encodingdf' = data.frame(encode_testdf),
              'train_pred' = train_pred, 'test_pred' = test_pred,
              'test_acc' = l_testacc, 'train_acc' = l_trainacc))
}