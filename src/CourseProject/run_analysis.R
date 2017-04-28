# Create a data folder to store the unzipped files
if (!file.exists("./data")) {
    dir.create("data")
}

# Create a temporary file to hold the download
zipTemp <- tempfile()

# Download the required zip file into the temp folder
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = zipTemp)

# Unzip the file into the data directory
unzip(zipTemp, exdir = "./data");
unlink(zipTemp)