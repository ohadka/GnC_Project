
## setup, download and unzip steps ***

# Set working directory
setwd("C:/Users/Ohadk/Desktop/GnC Project")

# Load required packages
library(plyr)
library(dplyr)

# Download, unzip data files and move to data sets
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
Dest<-"C://Users//Ohadk//Desktop//GnC Project//data.zip"
download.file(fileurl,Dest) ## download the file from the web
unzip(Dest) ## unzip the data file

Actlabels_dest<-"C:\\Users\\Ohadk\\Desktop\\GnC Project\\UCI HAR Dataset\\activity_labels.txt"
Actlabels <- read.table(Actlabels_dest) #enter activity labels into dataset

featlabels_dest<-"C:\\Users\\Ohadk\\Desktop\\GnC Project\\UCI HAR Dataset\\features.txt"
featlabels <- read.table(featlabels_dest) #enter feature labels into dataset

test_data_dest<-"C:\\Users\\Ohadk\\Desktop\\GnC Project\\UCI HAR Dataset\\test\\X_test.txt"
testdata <- read.table(test_data_dest) #enter test data into dataset
test_label_dest<-"C:\\Users\\Ohadk\\Desktop\\GnC Project\\UCI HAR Dataset\\test\\y_test.txt"
testlabels <- read.table(test_label_dest) #enter test labels into dataset
test_vol_dest<-"C:\\Users\\Ohadk\\Desktop\\GnC Project\\UCI HAR Dataset\\test\\subject_test.txt"
testvol <- read.table(test_vol_dest) #enter test Volunteer into dataset

train_data_dest<-"C:\\Users\\Ohadk\\Desktop\\GnC Project\\UCI HAR Dataset\\train\\X_train.txt"
traindata <- read.table(train_data_dest) #enter train data into dataset
train_label_dest<-"C:\\Users\\Ohadk\\Desktop\\GnC Project\\UCI HAR Dataset\\train\\y_train.txt"
trainlabels <- read.table(train_label_dest) #enter train labels into dataset
train_vol_dest<-"C:\\Users\\Ohadk\\Desktop\\GnC Project\\UCI HAR Dataset\\train\\subject_train.txt"
trainvol <- read.table(train_vol_dest) #enter train Volunteer into dataset


## run_analysis function ***
run_analysis <- function(test_data,test_vol,test_labels,train_data,train_vol,train_labels,act_labels,feat_labels) {

colnames(act_labels) <- c("Label","Activity_name") # rename data frame columns

# bind the test data and training with the volenteers and labels
test_all<-cbind(test_vol,test_labels) # combine Volenteers vector with Activity labels vector
test_all<-cbind(test_all,test_data) # combine the volenteer and activity with data set
colnames(test_all)[1] <- "Volenteer" # rename first column
colnames(test_all)[2] <- "Label" # rename Second column
train_all<-cbind(train_vol,train_labels) # combine Volenteers vector with Activity labels vector
train_all<-cbind(train_all,train_data) # combine the volenteer and activity with data set
colnames(train_all)[1] <- "Volenteer" # rename first column
colnames(train_all)[2] <- "Label" # rename Second column

# 1. Merging Testing and Training datasets
all_data<-bind_rows(test_all,train_all)

# 2.Extract only the measurements on the mean and standard deviation for each measurement
onlymean<-grep("-mean()", featlabels[,2]) # Identify features that include "mean"
onlystd<-grep("-std()", featlabels[,2]) # Identify features that include "std"
mnsindicator<-as.integer(sort(unique(c(onlymean,onlystd)))) # integrate both vectors into 1 unique and sorted vector
ans2<-all_data[,1:2] # establish a data frame with the volenteer and activity id
for (i in 1:length(mnsindicator)){ # Loop though the column indicators list and ass those columns to the new data frame
  ans2<-cbind(ans2,all_data[,2+mnsindicator[i]]) # Construct the required data frame (includes only the measurements on the mean and standard deviation for each measurement)
}

# 3. Rename Activities with descriptive activities names
ans2<-merge(ans2,act_labels,by="Label")[, union(names(ans2), names(act_labels))]

# 4. Appropriately label the data set with descriptive variable names
for (i in 1:length(mnsindicator)){ # Loop though the column indicators list and rename columns
  colnames(ans2)[2+i]<-toString(featlabels[mnsindicator[i],2]) # change column names
}

# 5. Creates a second tidy data set with the average of each variable for each activity and each subject
Act<-group_by(ans2,Activity_name,Volenteer) # create a grouped structure by Activity and Volenteer
tidy_data<-summarise_each(Act,funs(mean)) # summerize the new structure
write.table(tidy_data,"tidy_data.txt",row.names=FALSE) # export tiday data set to a .txt file
}