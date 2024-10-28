# Random forest voting at the end of every layer to achieve the acc  
vote_acc = function(train_df, train_predf, test_df, test_predf, y){
  # train_df : actual train df | train_predf : predicted df 
  # test_df : actual test df | test_predf : predicted df 
  
  # train voting
  train_predf = data.frame(cbind(train_predf, 'Vote' = apply(train_predf, 1, function(x) names(which.max(table(x))))), stringsAsFactors = F)
  # train acc
  tr_acc = acc_df(train_predf[['Vote']], train_df[[y]])
  cat('RF train acc', tr_acc)
  # test voting
  test_predf = data.frame(cbind(test_predf, 'Vote' = apply(test_predf, 1, function(x) names(which.max(table(x))))), stringsAsFactors = F)
  # test acc
  te_acc = acc_df(test_predf[['Vote']], test_df[[y]])
  cat(' | test acc', te_acc,'\n')
  return(list('train' = tr_acc, 'test' = te_acc))
}
