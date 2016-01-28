# install dependences
#to read tables
if (!require("data.table")) {
  install.packages("data.table")
}

require("data.table")
require("reshape2")


# we download the file into the workspace and 
# unzip de file
fileulr <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(fileulr, destfile = "filezip.zip", method="curl")
#unzip("filezip.zip")

# reading test files
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
Y_test <-  read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <-  read.table("UCI HAR Dataset/test/subject_test.txt")

#reading training files
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
Y_train <-  read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <-  read.table("UCI HAR Dataset/train/subject_train.txt")

#merge data
data_subject <- rbind(subject_train, subject_test)
data_activity <- rbind(Y_train, Y_test)
features <- read.table("UCI HAR Dataset/features.txt")[,2]
data_features <- rbind(X_train, X_test)
names(data_features) <- features

# 1.- Merges the training and the test sets to create one data set.
data <- cbind(data_subject, data_activity, data_features)

# 2.- Extracts only the measurements on the mean and standard deviation
# for each measurement.
columns_mean_std <- grep(".*Mean.*|.*Std.*", names(data), ignore.case=TRUE)
data_mean_std <- data[columns_mean_std,]

# 3.- Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")[,2]
data[,2] = activity_labels[data[,2]]

# 4.- Appropriately labels the data set with descriptive variable names.
names(data)[1] = "subject"
names(data)[2] = "activity"
names(data)<-gsub("^t", "time", names(data))
names(data)<-gsub("^f", "frequency", names(data))
names(data)<-gsub("Acc", "Accelerometer", names(data))
names(data)<-gsub("Gyro", "Gyroscope", names(data))
names(data)<-gsub("Mag", "Magnitude", names(data))
names(data)<-gsub("BodyBody", "Body", names(data))

# 5.-From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.

aggregated_data <- aggregate(data[, 3:ncol(data)],
                       by=list(subject = data$subject, 
                               activity = data$activity),
                       mean)
# write into a file
write.table(aggregated_data, file = "tidydata.txt",row.name=FALSE)
