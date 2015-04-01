library("psych")
setwd("c:/Users/Rishabh/Documents/GitHub/kForest/")

clean.data <- function() {

  #load train data
  train <- read.csv("data/train.csv", header = T)
  cover_type <- train[,length(train)]
  train <- train[, -c(1, length(train))]

  #write train data to file
  save(train, file = "data/train.RData")
  save(cover_type, file = "data/cover_type.RData")

  #Load test data
  test <- read.csv("data/test.csv", header = T)
  id <- test[,1]
  test <- test[,-1]

  #write train data to file
  save(test, file = "data/test.RData")
  save(id, file = "data/id.RData")
}

rescale.col <- function(x, old.min, old.max, new.min = 0, new.max = 1) {
  old.range = old.max - old.min
  new.range = new.max - new.min
  new.value = (((x - old.min) * new.range) / old.range) + new.min
  new.value
}

rescale.test.train <- function(){
  load("data/test.RData")
  load("data/train.RData")

  train[,2] <- train[,2] * pi / 180
  train[,3] <- train[,3] * pi / 180
  train$Aspect.sin <- sin(train[,2])
  train$Aspect.cos <- cos(train[,2])
  train$Slope.sin <- sin(train[,3])
  train$Slope.cos <- cos(train[,3])
  train <- train[, -c(2,3)]

  test[,2] <- test[,2] * pi / 180
  test[,3] <- test[,3] * pi / 180
  test$Aspect.sin <- sin(test[,2])
  test$Aspect.cos <- cos(test[,2])
  test$Slope.sin <- sin(test[,3])
  test$Slope.cos <- cos(test[,3])
  test <- test[, -c(2,3)]

  for(i in c(1:4, 8)) {
    old.max <- max(test[,i])
    old.min <- min(train[,i])

    test[,i] <- rescale.col(test[,i], old.min, old.max)
    train[,i] <- rescale.col(train[,i], old.min, old.max)
  }

  for(i in c(53:56)) {
    test[,i] <- rescale.col(test[,i], -1, 1)
    train[,i] <- rescale.col(train[,i], -1, 1)
  }

  for(i in c(5:7)) {
    test[,i] <- rescale.col(test[,i], 0, 255)
    train[,i] <- rescale.col(train[,i], 0, 255)
  }

  test.scale <- test
  train.scale <- train

  save(test.scale, file = "data/test_scale.Rdata")
  save(train.scale, file = "data/train_scale.Rdata")
}