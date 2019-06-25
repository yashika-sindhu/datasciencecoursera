download.file(url="https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv",destfile = "Desktop/pml-training.csv")
download.file(url="https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv",destfile = "Desktop/pml-testing.csv")

training<-read.csv("Desktop/pml-training.csv")
testing<-read.csv("Desktop/pml-testing.csv")

library(caret)
set.seed(1000)
intrain<-createDataPartition(y=training$classe,p=0.7,list=FALSE)
validation<-training[-intrain,]
training<-training[intrain,]

#Calculating and removing, factors & number vars, which have >95% vals as NA
k<-sapply(training,is.factor)
training_factors<-training[,k]
#37 total factors, genuine factors c("user_name","cvtd_timestamp","new_window","classe")
#But first 3 are not going to impact my classe var, hence removing them from data
#rest 33 have very high no of NA values, and are not useful. Hence removing them
#also first 7 vars are details about the people taking test and time stamps, so we remove them too
p_na<-names(training)[1:7]
p_na<-(append(p_na,names(training_factors)[1:36]))
l<-array()
for(i in 1:dim(training)[2]){l[i]<-sum(is.na(training[,i]))}
p_na<-append(p_na,names(training)[l>0.95*dim(training)[1]])

training_prep<-training[,!(names(training) %in% p_na)]
validation_prep<-validation[,!(names(validation) %in% p_na)]
testing_prep<-testing[,!(names(testing) %in% p_na)]

#fitting multiple models on training_prep and checking their accuracy on validation_prep
#using k-fold cross validation method

set.seed(1000)
fit1<-train(classe~.,method="treebag",data=training_prep,trControl=trainControl(method="cv"))
confusionMatrix(predict(fit1,validation_prep),validation_prep$classe)
# Accuracy is 0.9856

set.seed(1000)
fit2<-train(classe~.,method="gbm",data=training_prep,trControl=trainControl(method="cv"),verbose=FALSE)
confusionMatrix(predict(fit2,validation_prep),validation_prep$classe)
# Accuracy is 0.9611

set.seed(1000)
fit3<-train(classe~.,method="rf",data=training_prep,trControl=trainControl(method="cv"))
confusionMatrix(predict(fit3,validation_prep),validation_prep$classe)
# Accuracy is 0.9925

#Since accuracy of fit3 is the best, we will take fit3 as the final model
final_testing_results<-predict(fit3,testing_prep)
final_testing_results
#[1] B A B A A E D B A A B C B A E E A B B B
#Levels: A B C D E
