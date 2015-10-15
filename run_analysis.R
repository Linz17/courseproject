## 1. Merges the training and the test sets to create one data set.

## download / extract
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "dataset.zip", method = "curl")
unzip("dataset.zip")

## Reads provided files
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header=F)       
features <- read.table("./UCI HAR Dataset/features.txt", header=F)

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=F)        
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header=F) 
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header=F)

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=F)     
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header=F) 
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header=F)

## Gets number of observations
obs_test <- dim(subject_test)[1] 
obs_train <- dim(subject_train)[1] 
obs <- obs_test + obs_train   

## Gets number of variables
variables <- dim(subject_test)[2] + dim(y_test)[2] + dim(x_test)[2]               
dataset <- data.frame(matrix(NA, nrow=obs, ncol=variables))   

dataset[1:obs_test,1] <- subject_test
dataset[(obs_test +1):obs,1] <- subject_train
dataset[1:obs_test,2] <- y_test
dataset[(obs_test +1):obs,2] <- y_train
dataset[1:obs_test,3:563] <- x_test 
dataset[(obs_test +1):obs,3:563] <- x_train 

## 3. Uses descriptive activity names to name the activities in the data set
for (i in 1:obs) {
  z <- dataset[i,2]
  dataset[i,2] <- as.character(activity_labels[z,2])
}

## 4. Appropriately labels the data set with descriptive variable names. 
names(dataset) <- c("subject", "activity", as.character(features[,2]))   


## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
meansd <- c(grep("mean()", names(dataset)), grep("std()", names(dataset)))
ds_meansd <- dataset[,c(1:2, meansd)]

## 5. From the data set in step 4, creates a second, independent tidy data set with the average 
##    of each variable for each activity and each subject.

tidydata <- read.table(text = "", col.names = names(ds_meansd))

by_subject <- split(ds_meansd, ds_meansd$subject)
for (i in 1:length(by_subject)) {
  sbj <- data.frame(by_subject[i])
  names(sbj) <- names(ds_meansd)
  sbj.x <- subset(sbj, select= -activity)
  sbj.s <- subset(sbj, select= activity)
  x <- aggregate(sbj.x, sbj.s, mean)
  tidydata <- rbind(tidydata, x)
}
