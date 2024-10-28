# Function for extracting rule-based C5.0 rules
extractRules.rbC5.0 <- function(modparty) {
  # get rule from C50()
  pred_region <- pathpred(modparty)
  rules <- as.vector(unique(pred_region$rule)) 
  rules <- gsub(pattern = "\"", replacement = "'", x = rules)
  rules <- gsub(pattern = "'NA', ", replacement = "", x = rules )
  rules <- gsub(pattern = ", 'NA'", replacement = "", x = rules )
  
  return(rules)
  #rules <- strsplit(rules$output, split = "Rule ")[[1]]
  #rules <- gsub(pattern = " = ", replacement = " %in% ", x = rules)
  #rules <- gsub(pattern = " in ", replacement = " %in% ", x = rules)
  # # self - add
  # rules = gsub(pattern = " = ([<+/_0-9a-zA-Z ]*) &", " == '\\1' &", x = rules) # add '' to categorical feature 
  # # verification_status = Not Verified  --->  verification_status = 'Not Verified '
  # rules = gsub(pattern = " = ([<+/_0-9a-zA-Z ]*)$", " == '\\1'", x = rules) # if it's at the end of rule 
  # rules = gsub(pattern = " (in) ", " %\\1% ", x = rules) # categorical feature
  # # verification_status in c('Source Verified, Verified') ---> verification_status %in% c('Source Verified, Verified')
  # rules <- gsub(pattern = ", ", replacement = "', '", x = rules)
  # rules <- gsub(pattern = "% ([^ c(')]+)", replacement = "% c('\\1')", x =rules)
  
}