Getting and Cleaning Data Course Project CodeBook
=================================================
This file describes the variables, the data, and the transformation carried out for the assingment.  
* The data were obtained from The data for the project:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
* The run_analysis.R script performs the following steps:   
 1. Read X_train.txt, y_train.txt and subject_train.txt from the "/train" folder and store them in *X_train*, *y_train* and *subject_train* variables respectively.           
 2. Read X_test.txt, y_test.txt and subject_test.txt from the "/test" folder and store them in *X_test*, *y_test* and *subject_test* variables respectively.  
 3. Concatenate *X_train* to *X_test* to generate the data_features dataframe; concatenate *y_train* to *y_test* to generate the data_activity data frame; concatenate *subject_test* to *subject_train* to generate the subject dataframe.  
 4. Read the features.txt file andstore the data in a variable called *features*. We rename the data_features column name.  
 5.- Merge test and train data
 6.- Obtain just the features with mean or std variables
 7.- Rename the colum names for subject and activity
 
