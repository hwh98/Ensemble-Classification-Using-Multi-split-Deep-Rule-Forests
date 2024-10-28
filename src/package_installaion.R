# Define a vector of package names
packages <- c(
  "data.table",
  "coop",
  "stringr",
  "rpart",
  "rpart.plot",
  "C50",
  "xgboost",
  "tidyr",
  "dplyr",
  "party",
  "partykit",
  "doMC",
  "ggplot2",
  "onehot"
)

# Install packages
for (package in packages) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package, dependencies = TRUE)
  }
}