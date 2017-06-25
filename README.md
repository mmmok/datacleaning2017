This explains the analysis the script run_analysis.R performs.

## Introduction

The file run_analysis.R contains the following main functions. Each of them performs a crucial step of the analysis, as required by the Getting and Cleaning Data Course Project.

 * merge - Merges the training and the test sets to create one data set. First reads features, activity and subject data files for both train and test groups. Then binds all the observations on one data frame. Returns the resultant data frame.
 * extract - Extracts only the measurements on the mean and standard deviation for each measurement. First, reads features list file (features.txt); selects just the features that end with "-mean()" or "-std()". Then uses those features indices to select column in the given data frame. The given data frame must have columns 1 to 561 corresponding to features (just as function merge returns).
 * adjust_activities - Uses descriptive activity names to name the activities in the data set. Just turn activity variable to factor with labels "walking", "upstairs", "downstairs", "sitting", "standing" and "laying".
 * label - Appropriately labels the data set with descriptive variable names. First, reads features list file (features.txt); selects just the features that end with "-mean()" or "-std()". Transforms these sufixes to "Mean" and "Std", respectively. Then sets these names to the first columns of the given data frame, that must match (just as function extract returns).
 * summ - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. This is easily done with functions group_by and summarise from package dplyr.

## Pre-requisites

The directory called "UCI HAR Dataset" must be on the working directory.
