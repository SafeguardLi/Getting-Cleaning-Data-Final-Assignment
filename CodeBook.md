---
title: "CodeBook - tidydata"
author: "Wangzhi Li"
date: "Sep. 1st, 2018"
output: html_document
---

## Project Description

The tidydata data set comes from the UCI HAR Dataset and contians the ID variables(activitylables and subjects) and the average of each selected feature for each activity and each subject. Features selected in tidy data include the measurements on the mean and standard deviation for each measurement in orignal experiment. 

More info about UCI HAR Dataset is available: 
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

##Study design and data processing

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

###Collection of the raw data

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 


##Creating the tidy datafile

###Guide to create the tidy data file

1. Download the data
2. Read the files into R

###Cleaning of the data

1. Combine test_X data with train_X data.
2. Extract only the measurements on the mean and standard deviation for each measurement;
3. Uses descriptive activity names to name the activities in the data set;
4. Combine measurements data with Id Variables, i.e. subject and activity lables;
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject;
6. Appropriately labels the data set with descriptive variable names; 
7. Output the tidy data set, named tidydata.txt.
[See 'README.md' for more details. ]()

##Description of the variables in the tidydata.txt file

There are 180 observation of 68 variables in tidydata data set:

Among the 68 variables, 2 of them are ID varaibales(activitylables and subject) which indicate which activity a certain subject performs; 66 of them are measurements and their names follow certain schemas:

NoTE: 'XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAccXYZ
tGravityAccXYZ
tBodyAccJerkXYZ
tBodyGyroXYZ
tBodyGyroJerkXYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAccXYZ
fBodyAccJerkXYZ
fBodyGyroXYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

Plus, The set of variables that were estimated from these signals are: 

* mean: Mean value
* std: Standard deviation



### activitylabels          
: Factor w/ 6 levels "WALKING","WALKING_UPSTAIRS",..: 1 2 3 4 5 6 1 2 3 4 ...
 
### subject                 
: Factor w/ 30 levels "1","10","11",..: 1 1 1 1 1 1 2 2 2 2 ...
 
### tBodyAccmeanX           
: num  0.277 0.255 0.289 0.261 0.279 ...
 
### tBodyAccmeanY           
: num  -0.01738 -0.02395 -0.00992 -0.00131 -0.01614 ...
 
### tBodyAccmeanZ           
: num  -0.1111 -0.0973 -0.1076 -0.1045 -0.1106 ...
 
### tBodyAccstdX            
: num  -0.284 -0.355 0.03 -0.977 -0.996 ...
 
### tBodyAccstdY            
: num  0.11446 -0.00232 -0.03194 -0.92262 -0.97319 ...
 
### tBodyAccstdZ            
: num  -0.26 -0.0195 -0.2304 -0.9396 -0.9798 ...
 
### tGravityAccmeanX        
: num  0.935 0.893 0.932 0.832 0.943 ...
 
### tGravityAccmeanY        
: num  -0.282 -0.362 -0.267 0.204 -0.273 ...
 
### tGravityAccmeanZ        
: num  -0.0681 -0.0754 -0.0621 0.332 0.0135 ...
 
### tGravityAccstdX         
: num  -0.977 -0.956 -0.951 -0.968 -0.994 ...
 
### tGravityAccstdY         
: num  -0.971 -0.953 -0.937 -0.936 -0.981 ...
 
### tGravityAccstdZ         
: num  -0.948 -0.912 -0.896 -0.949 -0.976 ...
 
### tBodyAccJerkmeanX       
: num  0.074 0.1014 0.0542 0.0775 0.0754 ...
 
### tBodyAccJerkmeanY       
: num  0.028272 0.019486 0.02965 -0.000619 0.007976 ...
 
### tBodyAccJerkmeanZ       
: num  -0.00417 -0.04556 -0.01097 -0.00337 -0.00369 ...
 
### tBodyAccJerkstdX        
: num  -0.1136 -0.4468 -0.0123 -0.9864 -0.9946 ...
 
### tBodyAccJerkstdY        
: num  0.067 -0.378 -0.102 -0.981 -0.986 ...
 
### tBodyAccJerkstdZ        
: num  -0.503 -0.707 -0.346 -0.988 -0.992 ...
 
### tBodyGyromeanX          
: num  -0.0418 0.0505 -0.0351 -0.0454 -0.024 ...
 
### tBodyGyromeanY          
: num  -0.0695 -0.1662 -0.0909 -0.0919 -0.0594 ...
 
### tBodyGyromeanZ          
: num  0.0849 0.0584 0.0901 0.0629 0.0748 ...
 
### tBodyGyrostdX           
: num  -0.474 -0.545 -0.458 -0.977 -0.987 ...
 
### tBodyGyrostdY           
: num  -0.05461 0.00411 -0.12635 -0.96647 -0.98773 ...
 
### tBodyGyrostdZ           
: num  -0.344 -0.507 -0.125 -0.941 -0.981 ...
 
### tBodyGyroJerkmeanX      
: num  -0.09 -0.1222 -0.074 -0.0937 -0.0996 ...
 
### tBodyGyroJerkmeanY      
: num  -0.0398 -0.0421 -0.044 -0.0402 -0.0441 ...
 
### tBodyGyroJerkmeanZ      
: num  -0.0461 -0.0407 -0.027 -0.0467 -0.049 ...
 
### tBodyGyroJerkstdX       
: num  -0.207 -0.615 -0.487 -0.992 -0.993 ...
 
### tBodyGyroJerkstdY       
: num  -0.304 -0.602 -0.239 -0.99 -0.995 ...
 
### tBodyGyroJerkstdZ       
: num  -0.404 -0.606 -0.269 -0.988 -0.992 ...
 
### tBodyAccMagmean         
: num  -0.137 -0.1299 0.0272 -0.9485 -0.9843 ...
 
### tBodyAccMagstd          
: num  -0.2197 -0.325 0.0199 -0.9271 -0.9819 ...
 
### tGravityAccMagmean      
: num  -0.137 -0.1299 0.0272 -0.9485 -0.9843 ...
 
### tGravityAccMagstd       
: num  -0.2197 -0.325 0.0199 -0.9271 -0.9819 ...
 
### tBodyAccJerkMagmean     
: num  -0.1414 -0.4665 -0.0894 -0.9874 -0.9924 ...
 
### tBodyAccJerkMagstd      
: num  -0.0745 -0.479 -0.0258 -0.9841 -0.9931 ...
 
### tBodyGyroMagmean        
: num  -0.161 -0.1267 -0.0757 -0.9309 -0.9765 ...
 
### tBodyGyroMagstd         
: num  -0.187 -0.149 -0.226 -0.935 -0.979 ...
 
### tBodyGyroJerkMagmean    
: num  -0.299 -0.595 -0.295 -0.992 -0.995 ...
 
### tBodyGyroJerkMagstd     
: num  -0.325 -0.649 -0.307 -0.988 -0.995 ...
 
### fBodyAccmeanX           
: num  -0.2028 -0.4043 0.0382 -0.9796 -0.9952 ...
 
### fBodyAccmeanY           
: num  0.08971 -0.19098 0.00155 -0.94408 -0.97707 ...
 
### fBodyAccmeanZ           
: num  -0.332 -0.433 -0.226 -0.959 -0.985 ...
 
### fBodyAccstdX            
: num  -0.3191 -0.3374 0.0243 -0.9764 -0.996 ...
 
### fBodyAccstdY            
: num  0.056 0.0218 -0.113 -0.9173 -0.9723 ...
 
### fBodyAccstdZ            
: num  -0.28 0.086 -0.298 -0.934 -0.978 ...
 
### fBodyAccJerkmeanX       
: num  -0.1705 -0.4799 -0.0277 -0.9866 -0.9946 ...
 
### fBodyAccJerkmeanY       
: num  -0.0352 -0.4134 -0.1287 -0.9816 -0.9854 ...
 
### fBodyAccJerkmeanZ       
: num  -0.469 -0.685 -0.288 -0.986 -0.991 ...
 
### fBodyAccJerkstdX        
: num  -0.1336 -0.4619 -0.0863 -0.9875 -0.9951 ...
 
### fBodyAccJerkstdY        
: num  0.107 -0.382 -0.135 -0.983 -0.987 ...
 
### fBodyAccJerkstdZ        
: num  -0.535 -0.726 -0.402 -0.988 -0.992 ...
 
### fBodyGyromeanX          
: num  -0.339 -0.493 -0.352 -0.976 -0.986 ...
 
### fBodyGyromeanY          
: num  -0.1031 -0.3195 -0.0557 -0.9758 -0.989 ...
 
### fBodyGyromeanZ          
: num  -0.2559 -0.4536 -0.0319 -0.9513 -0.9808 ...
 
### fBodyGyrostdX           
: num  -0.517 -0.566 -0.495 -0.978 -0.987 ...
 
### fBodyGyrostdY           
: num  -0.0335 0.1515 -0.1814 -0.9623 -0.9871 ...
 
### fBodyGyrostdZ           
: num  -0.437 -0.572 -0.238 -0.944 -0.982 ...
 
### fBodyAccMagmean         
: num  -0.1286 -0.3524 0.0966 -0.9478 -0.9854 ...
 
### fBodyAccMagstd          
: num  -0.398 -0.416 -0.187 -0.928 -0.982 ...
 
### fBodyBodyAccJerkMagmean 
: num  -0.0571 -0.4427 0.0262 -0.9853 -0.9925 ...
 
### fBodyBodyAccJerkMagstd  
: num  -0.103 -0.533 -0.104 -0.982 -0.993 ...
 
### fBodyBodyGyroMagmean    
: num  -0.199 -0.326 -0.186 -0.958 -0.985 ...
 
### fBodyBodyGyroMagstd     
: num  -0.321 -0.183 -0.398 -0.932 -0.978 ...
 
### fBodyBodyGyroJerkMagmean
: num  -0.319 -0.635 -0.282 -0.99 -0.995 ...
 
### fBodyBodyGyroJerkMagstd 
: num  -0.382 -0.694 -0.392 -0.987 -0.995 ...


