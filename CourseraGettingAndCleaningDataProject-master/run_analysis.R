## Download the zip data set into working directory
download.file(
  "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
  destfile = "course 2 project data set.zip"
)

## unzip the data set
unzip("course 2 project data set.zip")

## Labels for 6 different type of activities - data frame
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")

## Features of datasets
features<-read.table("UCI HAR Dataset/features.txt")

## Activity labels for train dataset - data frame
train_labels<-read.table("UCI HAR Dataset/train/y_train.txt")

## Activity labels for test dataset - data frame
test_labels<-read.table("UCI HAR Dataset/test/y_test.txt")

## Total subjects are 30 and 70% of it produce train data and 30% produce test data. 
## Sequence of train data subjects - data frame
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")

## Sequence of test data subjects - data frame
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")

## Train dataset features - data frame
train_x<-read.table("UCI HAR Dataset/train/X_train.txt")

## Test dataset features - data frame
test_x<-read.table("UCI HAR Dataset/test/X_test.txt")

## To make a tidy dataset (1) we need to merge training with subjects and activities

## Create the mean() and std() column number and column name data frame
mean_std<-data.frame()
for(i in 1:561){
  if(grepl("mean()",features[[2]][[i]]) | grepl("std()",features[[2]][[i]])){
    a<-data.frame()
    a[1,1]<-i;a[1,2]<-features[[2]][[i]]
    mean_std<-rbind(mean_std,a)
  }
}

## Merge activity name with test_labels and train_labels
test_labels<-merge(test_labels,activity_labels,by="V1")
train_labels<-merge(train_labels,activity_labels,by="V1")

## cbind() test_labels/train_labels to test subject number and train subject number
test_dataset<-data.frame()
test_dataset<-cbind(subject_test,test_labels)
train_dataset<-data.frame()
train_dataset<-cbind(subject_train,train_labels)
## Remove the activity number as we already have activity name
test_dataset[2]<-NULL
train_dataset[2]<-NULL

## Take columns of mean() and std() from test_x/train_x 
## and cbind() to test_dataset/train_dataset
test_dataset<-cbind(test_dataset,test_x[mean_std[[1]]])
train_dataset<-cbind(train_dataset,train_x[mean_std[[1]]])

## Now rbind() test_dataset and train_datasets
final_dataset1<-data.frame()
final_dataset1<-rbind(test_dataset,train_dataset)

## Naming the final_dataset1
colnames(final_dataset1)[1:2]<-c("Subject Number","Activity Name")
for(i in 1:79){
  colnames(final_dataset1)[2+i]<-as.character(mean_std[i,2])
}

## Here we have our tidy final_dataset1

## Now creating final_dataset2 using aggregate
final_dataset2<-aggregate(
  .~final_dataset1$`Subject Number`+final_dataset1$`Activity Name`,
  final_dataset1,
  mean
)
final_dataset2[1:2]<-NULL

## Here we have our tidy final_dataset2





