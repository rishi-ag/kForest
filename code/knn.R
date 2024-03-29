library("class")
setwd("c:/Users/Rishabh/Documents/GitHub/kForest/")

source("code/library.R")

load("data/train.RData")
load("data/test.RData")
load("data/id.RData")
load("data/cover_type.RData")
load("data/test_scale.Rdata")
load("data/train_scale.Rdata")

k.range <- c(1, 3, 5)

#test knn with cv
pred <- sapply(X = k.range, FUN = function(x) knn.cv(train = train, cl = cover_type, k = x))

error <- apply(X = pred, MARGIN = 2, FUN =  function(x) sum(x != cover_type) / length(x))

#predict test data on raw
pred.test <- knn(train = train, test = test, cl = cover_type, k = 1)

#create submission file
knn.pred.test <- data.frame(Id = id, Cover_Type = pred.test)
write.csv(knn.pred.test, "data/knn/knn1_pred.csv", row.names = FALSE)

#test knn with cv sclaed data
pred <- sapply(X = k.range, FUN = function(x) knn.cv(train = train.scale, cl = cover_type, k = x))
error <- apply(X = pred, MARGIN = 2, FUN =  function(x) sum(x != cover_type) / length(x))
