pathpred <- function(object, ...)
{
  ## coerce to "party" object if necessary
  if(!inherits(object, "party")) object <- as.party(object)
  
  ## get standard predictions (response/prob) and collect in data frame
  rval <- data.frame(response = predict(object, type = "response", ...))
  rval$prob <- predict(object, type = "prob", ...)
  
  ## get rules for each node
  rls <- partykit:::.list.rules.party(object)
  
  ## get predicted node and select corresponding rule
  rval$rule <- rls[as.character(predict(object, type = "node", ...))]
  
  return(rval)
}