# Create a temp file to hold the download
zipTemp <- tempfile()

# Download the required zip file into the temp file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = zipTemp)

# Extract the activity types and features used in the files to be used in the column names and factors
activity_label_data <- read.table(unz(zipTemp, "UCI HAR Dataset/activity_labels.txt"),
                                  colClasses = c("integer", "character"),
                                  col.names = c("ACTIVITY_ID", "ACTIVITY_NAME"))

feature_column_names <- read.table(unz(zipTemp, "UCI HAR Dataset/features.txt"),
                                   colClasses = c("integer", "character"),
                                   col.names = c("COLUMN_ID", "FEATURE_NAME"))

# Find only the column names for the mean() and std() values
required_columns <- subset(feature_column_names, grepl("(mean\\(\\))|(std\\(\\))", feature_column_names$FEATURE_NAME))

# Utility functions to build column class and column name vectors to help 
# extract only the required columns from the test and training data files 
formatColumnType <- function(column) {
    column_type <- "NULL"

    found_column <- required_columns[required_columns$COLUMN_ID == column,]$FEATURE_NAME
    if (length(found_column) > 0) {
        column_type <- "numeric"
    }

    return(column_type)
}

formatColumnName <- function(column) {
    column_name <- "NULL"

    found_column <- required_columns[required_columns$COLUMN_ID == column,]$FEATURE_NAME
    if (length(found_column) > 0) {
        found_column <- sub("\\(\\)", "", found_column)
        found_column <- gsub("-", "_", found_column)

        if (grepl("Body", found_column)) {
            found_column <- gsub("Body", "_Body", found_column)
        }

        if (grepl("Gravity", found_column)) {
            found_column <- sub("Gravity", "_Gravity", found_column)
        }

        if (grepl("Gyro", found_column)) {
            found_column <- sub("Gyro", "_Gyro", found_column)
        }

        if (grepl("Acc", found_column)) {
            found_column <- sub("Acc", "_Acceleration", found_column)
        }

        if (grepl("Jerk", found_column)) {
            found_column <- sub("Jerk", "_Jerk", found_column)
        }

        if (grepl("Mag", found_column)) {
            found_column <- sub("Mag", "_Magnitude", found_column)
        }

        if (grepl("^t", found_column)) {
            found_column <- sub("t", "TIME", found_column)
        } else {
            found_column <- sub("f", "FREQUENCY", found_column)
        }

        column_name <- toupper(found_column)
    }

    return(column_name)
}

# Build the column class and column name vectors
column_list <- sapply(feature_column_names$COLUMN_ID, formatColumnName)
column_classes <- sapply(feature_column_names$COLUMN_ID, formatColumnType)

# Read in the test data
test_subject_data <- read.table(unz(zipTemp, "UCI HAR Dataset/test/subject_test.txt"),
                                col.names = c("SUBJECT_ID"))
test_y_data <- read.table(unz(zipTemp, "UCI HAR Dataset/test/y_test.txt"),
                          colClasses = c("integer"),
                          col.names = c("ACTIVITY_ID"))
test_x_data <- read.table(unz(zipTemp, "UCI HAR Dataset/test/X_test.txt"),
                          colClasses = column_classes,
                          col.names = column_list)

# Read in the training data
train_subject_data <- read.table(unz(zipTemp, "UCI HAR Dataset/train/subject_train.txt"),
                                 col.names = c("SUBJECT_ID"))
train_y_data <- read.table(unz(zipTemp, "UCI HAR Dataset/train/y_train.txt"),
                           colClasses = c("integer"),
                           col.names = c("ACTIVITY_ID"))
train_x_data <- read.table(unz(zipTemp, "UCI HAR Dataset/train/X_train.txt"),
                           colClasses = column_classes,
                           col.names = column_list)

# Clean up the temp file
unlink(zipTemp)
rm(zipTemp)

# Clean up and put all the columns together for the the test data
test_activity_data <- merge(test_y_data, activity_label_data)
test_data <- cbind(test_subject_data, ACTIVITY_NAME = test_activity_data$ACTIVITY_NAME, test_x_data)

# Clean up and put all the columns together for the training data
train_activity_data <- merge(train_y_data, activity_label_data)
train_data <- cbind(train_subject_data, ACTIVITY_NAME = train_activity_data$ACTIVITY_NAME, train_x_data)

# Merge all the rows into a resulting dataset
merged_data <- rbind(test_data, train_data)



distinct_subjects <- unique(merged_data$SUBJECT_ID)
column_names <- column_list[column_list != "NULL"]

result_data <- data.frame()
for (subject in distinct_subjects) {
    for (activity in activity_label_data$ACTIVITY_NAME) {

        activity_result <- cbind(SUBJECT_ID = c(subject), ACTIVITY_NAME = c(activity))

        grouped_data <- merged_data[merged_data$SUBJECT_ID == subject && merged_data$ACTIVITY_NAME == activity,]

        for (column in column_names) {
            if (nrow(grouped_data) > 0) {
                activity_result <- cbind(activity_result, c(mean(grouped_data[, column], na.rm = TRUE)))
            } else {
                activity_result <- cbind(activity_result, c(NA))
            }
        }

        result_data <- rbind(result_data, activity_result)
    }
}
