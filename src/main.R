library(data.table)
library(coop)
library(stringr)
library(rpart)
library(rpart.plot)
library(C50)
library(xgboost)
library(tidyr)
library(dplyr)
library(party)
library(partykit)
library(doMC)
library(ggplot2)
library(onehot)
library(rstudioapi)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

source("./validate_aspartyC50.R")
source("./ruleforest.R")
source('./deep_rf.R')
source('./plot_accline.R')
source('./rowsample.R')
source('./columnsample.R')
source('./pathpred.R')
source('./extractRules_rbc50.R')
source('./vote_acc.R')
source('./acc_df.R')
source('./rule_encoding.R')



# prepare poker data 
poker_train = fread("../data/poker_train.csv",  stringsAsFactors = F,
                    verbose = T, data.table = F) 

colnames(poker_train) = c("S1", "C1", "S2", "C2", "S3", "C3", "S4", "C4", "S5", "C5", "hand")
poker_train$hand = factor(poker_train$hand, labels = c('1','2','3','4','5','6','7','8','9','10'))
# Suit(Hearts, Spades, Diamonds, Clubs)
for(i in c(paste("S", 1:5, sep = "") )){
  poker_train[, i] = factor(poker_train[, i], ordered = F)
}
# Rank(1-13)
for(i in c(paste("C", 1:5, sep = "") )){
  poker_train[, i] = factor(poker_train[, i], ordered = F)
}

# train-test split
train_idx = sample(1:nrow(poker_train),  0.7 * nrow(poker_train))
train_d = poker_train[train_idx, ] 
test_d = poker_train[-train_idx, ] 

# setting parameter for each layer 
parameter1 = list( list(min_case = 80, ntree = 20, mtry_ratio = 0.3), 
                   list(min_case = 80, ntree = 20, mtry_ratio = 0.3),
                   list(min_case = 80, ntree = 20, mtry_ratio = 0.3),
                   list(min_case = 80, ntree = 20, mtry_ratio = 0.3),
                   list(min_case = 80, ntree = 20, mtry_ratio = 0.3)
              )

# train DRF C50
start = Sys.time()
drf_poker = deep_rf(train_df = train_d, test_df = test_d, 
                    y = 'hand', parameter_list = parameter1, 
                    layer = length(parameter1), seed = 123) # return a list of each layer 
Sys.time() - start
