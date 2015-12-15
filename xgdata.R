#install.packages("caret")
library(caret)

# str()は要約の表示
str(d, list.len=ncol(d))
str(test, list.len=ncol(test))

# それぞれの変数に値を代入
d$Train_Flag    <- 1  #Add in a flag to identify if observations fall in train data, 1 train, 0 test
test$Response   <- NA #Add in a column for Response in the test data and initialize to NA
test$Train_Flag <- 0  #Add in a flag to identify if observations fall in train data, 1 train, 0 test

# separate "All_Data" to "train" $ "test"
train.for.xgboost <- All_Data[All_Data$Train_Flag==1,]    # Remove Id
test.for.xgboost  <- All_Data[All_Data$Train_Flag==0,]  # Remove Id $ Response

# make data to convert to csv format
smp_size <- floor(0.8 * nrow(train.for.xgboost))
set.seed(123)
train_rows <- sample(seq_len(nrow(train.for.xgboost)), size = smp_size)
train_large  <- train.for.xgboost[train_rows, ]          # 80% of train data
train_mini   <- train.for.xgboost[sample(1:nrow(train.for.xgboost), 1000), ]
valid_large  <- train.for.xgboost[-train_rows, ]         # rest data (20%)
valid <- valid_large[sample(1:nrow(valid_large),1000),]  # make valid data have 1,000 rows for simplicity of valid process
test_mini    <- test.for.xgboost[c(1:10),]

write.csv(train_large,       "out_for_xgboost/train.csv",       row.names=F)
write.csv(train_mini,        "out_for_xgboost/train_mini.csv",  row.names=F)
write.csv(valid,             "out_for_xgboost/valid.csv",       row.names=F)
#write.csv(test.for.pylearn2, "out_for_pylearn2/test.csv",        row.names=F)
#write.csv(test_mini,         "out_for_pylearn2/test_mini.csv",   row.names=F)


