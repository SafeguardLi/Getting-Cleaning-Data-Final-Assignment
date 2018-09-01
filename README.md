---
title: "README"
author: "Wangzhi Li"
date: "Sep. 1st, 2018"
output: html_document
---

This document would explains the analysis files as clear and understandable as possible.

## Part1: Introduction to this repo

This repo contains 4 files: README.md, CodeBook.md, run_analysis.R and tidydata.txt.

  * READ.md: introduces the whole repo and details the run_analysis.R.
  * CodeBook.md: modifies and updates the available codebooks with the original data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
  * run_analysis.R: the scrips of code.
  * tidydata.txt: the output file of run_analysis.R, which is a tidy and independent data set with the average of each variable for each activity and each subject.

## Part2: Info about the experiment

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

### For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


## Part3: Explanation for run_analysis.R

### Step0.1 Check the existence of the directory and files 

At the very begining, it checks the existence of files in certain directory, and if if there are no these files or that directory, it would create the directory or download and unpack the files we need. 
```
wd <- getwd()
if(!file.exists("./data")){
        dir.create("./data")  
}
if(!file.exists("./data/getdata_projectfiles_UCI HAR Dataset.zip")){
        url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(url, destfile="./data/getdata_projectfiles_UCI HAR Dataset.zip", method="curl")
}
if(!file.exists("./data/UCI HAR Dataset")){
        zipF<-file.choose() # choose a file and save its file path in R (at least for windows)
        outDir<-"./data" # Define the folder where the zip file should be unzipped to 
        unzip(zipF,exdir=outDir) 
}
setwd("./data/UCI HAR Dataset")
```

### Step0.2 Read files into R

Use `read.table` to read txt. format files into R (NOte: Only files that are needed in this assignment are read, i.e. **without files in the inertialSignals folders**):
```
features <- read.table("./features.txt")
trainX <- read.table("./train/X_train.txt")
testX <- read.table("./test/X_test.txt")
subjectTest <- read.table("./test/subject_test.txt")
subjectTrain <- read.table("./train/subject_train.txt")
trainY <- read.table("./train/Y_train.txt")
testY <- read.table("./test/Y_test.txt")
labels <- read.table("./activity_labels.txt")
```
### Step1. Merge the test and train sets to one data set

Use `rbind` to merge two datasets vertically: 
```
mergeddata <- rbind(trainX,testX)
```
### Step2. Extracts only the measurements on the mean and standard deviation for each measurement

Use `grep` to pinpoint `mean()` and `std()`in features, and return the row number in features which is exactly the column number in mergeddata;
Use `select` in `dplyr` package to subset the collumns:
```
library(dplyr)
dataset <- select(mergeddata,grep("mean\\(\\)|std\\(\\)",features[,2]))
```

### Step3. Uses descriptive activity names to name the activities in the data set

Firstly, merged the test_Y and train_Y datasets:
```
mergedY <- rbind(trainY,testY)
```
Then, convert its class from `interger` to `character` and to `factor` in the end, since directly converting from `integer` to `factor` would cause problem:
```
labelY <- as.character(mergedY[,1])
activitylabels <- as.factor(labelY)
```
Finally, assign the descriptive activity names from `labels` to the level names of these factors.
```
levels(activitylabels) <- labels[,2]
```

### Step4. Appropriately labels the data set with descriptive variable names

The vairable names in the dataset data set are V1,V2,V3...And the descriptive variable names are stored in the features. Thus, Using `grep` to extract the names from features and assigning them to dataset would label the data set correctly. 
However, considering our following opertions in Step 5, I postpone this step here.

### Step5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

Convert subject from `integer` to `factor` and combine it with the dataset:
```
dataset <- cbind(dataset, activitylabels)
mergedsubject <- rbind(subjectTrain,subjectTest)
subject <- as.character(mergedsubject[,1])
subject <- as.factor(subject)
dataset <- cbind(dataset, subject)
```
Create a new data set, named newdata, with `aggregate` function.
Use `for` loops to extract every column we need in the temp data set, since, unfortunately, I failed to find a better way to assign multiple variables in the left side of the formula in `aggregate`.
```
newdata <- aggregate(dataset[,1]~activitylabels+subject,data=dataset,mean)
for(i in 1:(ncol(dataset)-2)){
        temp<- aggregate(dataset[,i]~activitylabels+subject,data=dataset,mean)
        newdata[,i]  <- temp[,3]
}
```
Rename the variabel names of newdata,i.e. the **step4**
```
names(newdata) <- grep("mean\\(\\)|std\\(\\)",features[,2],value=TRUE)
names(newdata)<-gsub("-","",names(newdata))
names(newdata)<-gsub("\\(","",names(newdata))
names(newdata)<-gsub("\\)","",names(newdata))
```
And, extract the ID variables,i.e. activitylables and subject, and merge them with the newdata into tidydata.
```
temp<- aggregate(dataset[,1]~activitylabels+subject,data=dataset,mean)
tidydata <- cbind(temp[,1:2],newdata)
```

### The END
Output the txt. format file
```
write.table(tidydata,file="./tidydata.txt", row.name=FALSE)
setwd(wd)
```
At the end of the day, we generate a tidy data text file that meets the principles of tidy data, i.e. one vairable in each column , each observation in each row and each table stores data about one kind of observation.Also, all the names of variables and values are descriptive:).

