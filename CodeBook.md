# Coursera Getting and Cleaning Data Course Project Code Book

## Summary
The purpose of this guide is to provide the information to understand how the `run_analysis.R` file works and the expected output of the `analysis_result.txt` file.
***
### Variable Naming Convention
There are many variables names that signify different measurements taeken in the data set. This table list of the naming conventions to help identify the columns.

Convention  |   Description
--- |   ---
 __SUBJECT_ID__ | Denotes the subject the measurements were taken from
__ACTIVITY_NAME__   | Denotes the type of activity the subject was performing when the measurement was taken
__TIME\_*(Measurement Name)*__  | Denotes that the measurement was taken over time
__FREQUENCY\_*(Measurement Name)*__ | Denotes that the measurement was taken by the number of occurences
***
### Basic Transformation Step by Step
The code is commented with detailed descriptions of each step but the basic process is as follows:

1. Download the required zip file from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
2. Read in the generic data required for merging that include the following:
    * `UCI HAR Dataset/activity_labels.txt` *(Activity Classifications)*
    * `UCI HAR Dataset/features.txt` *(Activity Measurement Classifications)*
3. Build a list of required columns for measurements that are a mean or standard deviation for each axis *(when the axis values are available)*
4. Using the `formatColumnName` helper function create a vector of names to be used when reading in both the test and training data
5. Using the `formatColumnType` helper function create a vector of data types that will be used to read in only the required columns from the test and training data
6. Read in the test data for the subject and activity from the following:
    * `UCI HAR Dataset/test/subject_test.txt` *(Subject Data)*
    * `UCI HAR Dataset/test/y_test.txt` *(Activity Data)*
7. Using the column name and column data type vector read in the following test data:
    * `UCI HAR Dataset/test/X_test.txt` *(Measurement Data)*
8. Read in the training data for the subject and activity from the following:
    * `UCI HAR Dataset/train/subject_train.txt` *(Subject Data)*
    * `UCI HAR Dataset/train/y_train.txt` *(Activity Data)*
9. Using the column name and column data type vector read in the following test data:
    * `UCI HAR Dataset/train/X_train.txt` *(Measurement Data)*
10. Combine all of the columns for the test data set
11. Combine all of the columns for the training data set
12. Combine all of the rows from both the test and training data sets into a merged set
    * *__NOTE__ This result will take you to step 4 of the requirements*
13. Using the `dplyr` library group the merged data by subject and activity and get the average for each measurement
14. Write out the results to the `analysis_result.txt` file
    * *__NOTE__ This result will take you to step 5 of the requirements*