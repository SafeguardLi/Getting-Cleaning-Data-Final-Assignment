##Download and read the files into R
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

##Read files into R
features <- read.table("./features.txt")
trainX <- read.table("./train/X_train.txt")
testX <- read.table("./test/X_test.txt")
subjectTest <- read.table("./test/subject_test.txt")
subjectTrain <- read.table("./train/subject_train.txt")
trainY <- read.table("./train/Y_train.txt")
testY <- read.table("./test/Y_test.txt")
labels <- read.table("./activity_labels.txt")

##Step1. Merge the test and train sets to one data set
mergeddata <- rbind(trainX,testX)

##Step2. Extracts only the measurements on the mean and standard deviation for each measurement. 
library(dplyr)
dataset <- select(mergeddata,grep("mean\\(\\)|std\\(\\)",features[,2]))

##Step3. Uses descriptive activity names to name the activities in the data set
##Label of each observation, stored in test_Y and train_Y, is also a variable(a column)
##But it's untidy for its undescriptive name, 
##therefore before binding it to the dataset we should convert each number to its coresponding descriptive name
mergedY <- rbind(trainY,testY)
labelY <- as.character(mergedY[,1])
activitylabels <- as.factor(labelY)
levels(activitylabels) <- labels[,2]

##Step4. Appropriately labels the data set with descriptive variable names. 
##Note: Step4 would be processed after step5 considering the following operations.

##Step5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##Unfortunately, I failed to figure out a better wayout than for loops.
dataset <- cbind(dataset, activitylabels)
mergedsubject <- rbind(subjectTrain,subjectTest)
subject <- as.character(mergedsubject[,1])
subject <- as.factor(subject)
dataset <- cbind(dataset, subject)

newdata <- aggregate(dataset[,1]~activitylabels+subject,data=dataset,mean)
for(i in 1:(ncol(dataset)-2)){
        temp<- aggregate(dataset[,i]~activitylabels+subject,data=dataset,mean)
        newdata[,i]  <- temp[,3]
}

##Step4. 
names(newdata) <- grep("mean\\(\\)|std\\(\\)",features[,2],value=TRUE)
names(newdata)<-gsub("-","",names(newdata))
names(newdata)<-gsub("\\(","",names(newdata))
names(newdata)<-gsub("\\)","",names(newdata))
temp<- aggregate(dataset[,1]~activitylabels+subject,data=dataset,mean)
tidydata <- cbind(temp[,1:2],newdata)

##Output the txt. format file
write.table(tidydata,file="./tidydata.txt", row.name=FALSE)
setwd(wd)
##And then we generate a tidy data text file that meets the principles of tidy data, 
##i.e., one vairable in each column , each observation in each row and each table stores data about one kind of observation
##Also, all the names of variables and values are descriptive
