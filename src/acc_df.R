# accuracy check for c50 function outpu
acc_df <- function(pred, y){
  # set the level to the same 
  pred = factor(pred, levels=(levels(y)))
  
  # accuracy for c50 prediction.
  confusion = table(pred, y)
  return(sum(diag(confusion))/ length(y))
}