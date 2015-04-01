library("psych")
setwd("c:/Users/Rishabh/Documents/GitHub/kForest/")

clean.data <- function() {

  #load train data
  train <- read.csv("data/train.csv", header = T) 
  cover_type <- train[,length(train)]
  train <- train[, -c(1, length(train))]
  
  #write train data to file
  save(train, cover_type, file = "data/train.RData")
  
  #Load test data
  test <- read.csv("data/test.csv", header = T) 
  id <- test[,1]
  test <- test[,-1]
  
  #write train data to file
  save(test, id, file = "data/test.RData")
}