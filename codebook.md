# CodeBook

## Data source

* Data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Data Set Information & Experiment

* Description of the dataset & Experiment: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## The data

The dataset includes the following files:

- 'README.txt'
- 'features_info.txt': Features described
- 'features.txt': List of features.
- 'activity_labels.txt': Links the class labels and activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels
- 'test/X_test.txt': Test set
- 'test/y_test.txt': Test labels

The following files are train and test data

- 'train/subject_train.txt'
- 'train/Inertial Signals/total_acc_x_train.txt'
- 'train/Inertial Signals/body_acc_x_train.txt'
- 'train/Inertial Signals/body_gyro_x_train.txt'

## Analysis process as described in assignment paged

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
