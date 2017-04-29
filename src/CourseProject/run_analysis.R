# Create a temp file to hold the download
zipTemp <- tempfile()

# Download the required zip file into the temp folder
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = zipTemp)

# From the README.txt in the zip file extract the data from these paths
activity_label_data <- read.table(unz(zipTemp, "UCI HAR Dataset/activity_labels.txt"),
                                  col.names = c("ActivityId", "ActivityName"))

test_subject_data <- read.table(unz(zipTemp, "UCI HAR Dataset/test/subject_test.txt"),
                                col.names = c("SubjectId"))
test_y_data <- read.table(unz(zipTemp, "UCI HAR Dataset/test/y_test.txt"))
test_x_data <- read.table(unz(zipTemp, "UCI HAR Dataset/test/X_test.txt"))

#train_y_file <- "UCI HAR Dataset/train/y_train.txt"
#train_x_file <- "UCI HAR Dataset/train/X_train.txt"

#train_y_data <- read.table(unz(zipTemp, train_y_file))
#train_x_data <- read.table(unz(zipTemp, train_x_file))

# Clean up the temp file
unlink(zipTemp)
rm(zipTemp)