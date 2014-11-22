# Gets the data for Human Activity Recognition Using Smartphones Data Set 
# See: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

dataDir <- "data"

# Assignment instructions mention that data should exist 
# on the script's work directory, altough I think it
# would be better to unzip the file to ./data -- this can be done by
# updating the extractDir variable
extractDir <- "./"
dataFile <- paste0(dataDir, "/UCI_HAR_Dataset.zip")

# Creates the data dir if it does not exist
if(!file.exists(dataDir)) { dir.create(dataDir) }

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists(dataFile)) {
  download.file(fileUrl, destfile=dataFile, method="curl")
}

# unzips the file
unzip(dataFile, exdir=extractDir)
