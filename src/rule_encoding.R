# build encoding matrix : whether observation match the rule 
rule_encoding = function(rule, df, test_df, y){
  # df : training df 
  # test_df : testing df
  
  
  column_n = df %>% select(-y) # create  trained feature only matrix 
  train_tab <- matrix(0, nrow = nrow(df), # create empty matrix (#of df) x (#of rule)
                      ncol = length(rule),
                      dimnames = list(NULL, rule)) 
  
  # run string as a R command, so 'verification_status = Not Verified' will be run as a command
  attach(column_n) # make it easy to get the value in  with its column name
  for (j in 1:ncol(train_tab)) { # iterate each column(pattern)
    train_tab[eval(parse(text = rule[[j]])), j] <- 1
  }
  detach(column_n)
  # rename the train_tab column "S1 %in% c('1', '2', '4')" --->  "R1"
  rule_colnames = colnames(train_tab)
  rule_symbol = paste0(rep("R", length(rule_colnames)), seq(1 : length(rule_colnames)))
  colnames(train_tab) = rule_symbol
  # get the region 
  train_tab = data.frame(train_tab)
  train_tab$region = apply(train_tab, 1, function(x) names(which(x==1)))
  train_tab$region = unlist(lapply(train_tab$region, function(x) if(length(x)==0) 0 else x))# set region to `0` for those doesn't match any rule
  
  
  
  
  # testing data encoding
  column_test = test_df %>% select(-y)
  test_tab <- matrix(0, nrow = nrow(test_df),
                     ncol = length(rule),
                     dimnames = list(NULL, rule))
  attach(column_test) # make it easy to get the value in  with its column name
  for (j in 1:ncol(test_tab)) { # iterate each column(pattern)
    test_tab[eval(parse(text = rule[[j]])), j] <- 1
  }
  detach(column_test)
  #rename test_tab column with R1, R2, R3,...
  rule_colnames = colnames(test_tab)
  rule_symbol = paste0(rep("R", length(rule_colnames)), seq(1 : length(rule_colnames)))
  colnames(test_tab) = rule_symbol
  # get the region 
  test_tab = data.frame(test_tab)
  test_tab$region = apply(test_tab, 1, function(x) names(which(x==1)))
  test_tab$region = unlist(lapply(test_tab$region, function(x) if(length(x)==0) 0 else x))# set region to `0` for those doesn't match any rule
  
  # add in `y` col
  training_d = cbind(train_tab, df %>% select(y)) 
  testing_d = cbind(test_tab, test_df %>% select(y))
  
  return(list('training' = training_d, 'testing' = testing_d))
}
