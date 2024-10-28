# Multi-split DRF

Multi-split DRF implementation on poker dataset for now.


**main.R** : data preparation and run DRF model.

**deep_rf.R**: iterate each layer and record the rule_forest model and performance of that layer.

**rule_forest.R** : build C50 rule forest and do region encoding.

**rule_encoding.R** : match the observation to rule and get the final region for train, test observation.

**validate_aspartyC50.R** : replicate the `as.party.C5.0()` function to correctly extract rule.

**extractRules_rbcC50.R** : clean rule after the rule extract with `pathpred`.

**columnsample.R** : sample the column of both train,test with parameter **num_col** and return both.

_Note that we do column sample before we train one C50 tree, which means each trees will only see part of the column._

**rowsample.R** : row re-sampling to the same size (training data only).

**vote_acc.R** : voting after one RF to have the train,test acc.

**acc_df.R** : calculate the accuracy of prediction and actual.

**plot_accline.R** : plot the accuracy for layer-wised performance and RF.
