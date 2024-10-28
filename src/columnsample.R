
columnsample <- function(train_df, test_df, y, num_col, seed){
  
  # receive a dataframe and return a column-sampled df
  x_col = colnames(train_df)
  x_col = x_col[!x_col == y] # get the column name without `y`
  
  set.seed(seed)
  col_idx = sample(1:length(x_col), num_col)
  
  sampled_col = c(x_col[col_idx], y)
  sampled_df = train_df %>% select(sampled_col)
  sampled_testdf = test_df %>% select(sampled_col)
  return(list('train' = sampled_df, 'test' = sampled_testdf))
}