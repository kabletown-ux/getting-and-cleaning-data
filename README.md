# getting-and-cleaning-data

## Course Project
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Running analysis
1. Download & unzip [data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), should unzip to "UCI Har Dataset"
2. Move run_analysis.R into the data folder's parent dir
3. setwd() to dir containing run_analysis.R
4. Run "runAnalysis()" contained w/in run_analysis.R, creates tidiedMeans.txt  
