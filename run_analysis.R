#This script provides the necessary commands to run an analysis on the UCI HAR Dataset
#Either run by command line or in R Studio. 
#Requires files from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#Download and zip the directory into your working directory
#output of this is a file named "avg_data.txt"

#Check if necessary libraries are installed

if (!require(dplyr)) {
        stop("You are missing the package dplyr. Please install it before continuing.")
} else if (!require(dtplyr)) {
        stop("You are missing the package dtplyr Please install it before continuing.")
} else if (!require(data.table)) {
        stop("You are missing the package data.table. Please install it before continuing.")
}
#intializing necessary libraries
library(data.table)
library(dplyr)
library(dtplyr)

#Requires second script file that contains the functions used
source("analysis_functions.R")

#importing testing data
subject_test <- fread("./UCI HAR Dataset//test/subject_test.txt")
test_data <- fread("./UCI HAR Dataset//test/x_test.txt")
test_labels <- fread("./UCI HAR Dataset//test/y_test.txt")

#importing training data
subject_train <- fread("./UCI HAR Dataset/train/subject_train.txt")
train_data <- fread("./UCI HAR Dataset/train/X_train.txt")
train_labels <- fread("./UCI HAR Dataset/train/Y_train.txt")

#importing meta data
activity_labels <- fread("./UCI HAR Dataset/activity_labels.txt")
features <- fread("./UCI HAR Dataset/features.txt")

#Adds variable labels to the data
#Done early for use with data.table
#Done manually and by function
subject_train <- setnames(subject_train, "subject")
subject_test <- setnames(subject_test, "subject")
train_labels <- setnames(train_labels, "activity")
test_labels <- setnames(test_labels, "activity")
activity_labels <- setnames(activity_labels, c("factor","activity"))
test_data <- add_feature_names(test_data, features)
train_data <- add_feature_names(train_data, features)

#The following code does the bulk of the work

#Part 1: Merges the training and test files into tables
merged_testing_data <- merge_columns(subject_test, test_data, test_labels)
merged_training_data <- merge_columns(subject_train, train_data, train_labels)

#Merges the training and test data.tables
merged_data <- merge_rows(merged_training_data, merged_testing_data)

#Part 2: Extracts the columns that take the mean and std of the data
#along with identifying information
extracted_data <- extract_mean_std(merged_data)

#Part 3: Replaces the activity levels with their labels
extracted_data_rep <- replace_activities(extracted_data, activity_labels)

#Part 4: Tidies and labels data set, some of the labeling was done above
tidied_data <- tidy_data(extracted_data_rep)

#Part 5: averages the data and sorts by subject and activity
averaged_data <- average_data(tidied_data)

#Tidys the data a bit by adding meanof to the variable names
lab_averaged_data <- label_avg(averaged_data)

#Writes the data to a file
write.table(lab_averaged_data, "avg_data.txt", row.names=F)


