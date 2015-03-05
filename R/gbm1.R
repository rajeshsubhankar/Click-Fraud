require(gbm)

require(dplyr)
library(RCurl)
require(foreign)

CalculateAveragePrecision  <- function(expectedColumn, submittedColumn) {
  df  <- data.frame(expectedBySubmitted = expectedColumn, submitted = submittedColumn)
  print(df)
  df  <- df[order(df$submitted, decreasing = T),]
  df[, "expectedByExpected"] =sort(expectedColumn, decreasing = T)
  
  totalNumerator = 0.0;
  runningNumeratorExpected = 0.0;
  runningNumeratorActual = 0.0;
  
  print(df)
  
  for (i in 1:nrow(df)) {
    runningNumeratorExpected = runningNumeratorExpected + df$expectedByExpected[i]
    runningNumeratorActual = runningNumeratorActual + df$expectedBySubmitted[i]
    division = runningNumeratorActual/runningNumeratorExpected;
    totalNumerator = totalNumerator + division;
  }
  result = totalNumerator / nrow(df)
  result
}




train=read.arff(file = "final_120_train_w_labels.arff")
validation=read.arff(file ="final_120_validation_w_labels.arff")
test=read.arff(file = "final_120_test_w_labels.arff")

head(train)
summary(train)

train_status=train$status
print(train_status)
train=select(train, -status)
end_train=nrow(train)

validation_status=validation$status
print(validation_status)
validation=select(validation, -status)
end_validation=nrow(validation)

test_status=test$status
print(test_status)
test=select(test, -status)
end_test=nrow(test)


all=rbind(train,validation)
end_all=nrow(all)


head(all)
ntrees=5000
?gbm
train_status=as.numeric(train_status)-1
validation_status=as.numeric(validation_status)-1
test_status=as.numeric(test_status)-1
#print(train_status)


model=gbm.fit(
  x=all[1:end_train,]
  , y=train_status
  
  , distribution="bernoulli"
  , n.trees=ntrees
  , shrinkage=0.001
  , interaction.depth=5
  , n.minobsinnode=5
  
  
)

summary(model)

gbm.perf(model)


#preety.gbm.tree(model)

for(i in 1:length(model$var.names)){
  plot(model, i.var=i
       , ntrees=ntrees
       , type="response"
  )
}

ValidationPredictions=predict(object=model,newdata=all[(end_train+1):end_all,]
                        , n.trees=ntrees
                        , type="response")

TestPredictions=predict(object=model,newdata=test[1:end_test,]
                        , n.trees=ntrees
                        , type="response")

TrainPredictions=predict(object=model,newdata=all[1:end_train,]
                         , n.trees=ntrees
                         , type="response")


#CalculateAveragePrecision(validation_status, ValidationPredictions)

TestPredictions=round(TestPredictions)
TrainPredictions=round(TrainPredictions)
ValidationPredictions=round(ValidationPredictions)


gbm.roc.area(validation_status,ValidationPredictions)
gbm.roc.area(test_status,TestPredictions)

#head(TestPredictions,n=300)
#head(validation_status, n=300)

library(SDMTools)
confusion.matrix(validation_status,ValidationPredictions,0.5)
confusion.matrix(test_status,TestPredictions,0.5)



#print(conf)

library(caret)
conf<-table(ValidationPredictions,validation_status)
confusionMatrix(conf)

conf<-table(TestPredictions,test_status)
confusionMatrix(conf)

library(Metrics)
?apk
ValidationPredictions=as.vector(ValidationPredictions)
TestPredictions=as.vector(TestPredictions)
validation_status=as.vector(validation_status)
test_status=as.vector(test_status)


apk(end_validation,validation_status,ValidationPredictions)
apk(end_test,test_status,TestPredictions)

mapk(end_validation,validation_status,ValidationPredictions)
mapk(end_test,test_status,TestPredictions)

CalculateAveragePrecision(validation_status, ValidationPredictions)
CalculateAveragePrecision(test_status, TestPredictions)



#submission
submission=data.frame(y_test=TestPredictions)
write.csv(submission,file="y_test.csv", row.names=FALSE)

submission=data.frame(y_validation=ValidationPredictions)
write.csv(submission,file="y_validation.csv", row.names=FALSE)


