#row sample include stratified
rowsample <- function(train_df, seed, imb = F, y ){
  stratified_id = NULL
  if(imb){
    fewclass = names(which(table(train_df[[y]]) < 100))
    stratified_id = which(train_df[[y]] %in% fewclass)
  }
  row_idx = sample(1:nrow(train_df), replace = TRUE, size = length(train_df[[y]]) - length(stratified_id))
  row_idx = c(row_idx, stratified_id)
  sampled_df = train_df[row_idx,]
  return(sampled_df)
}