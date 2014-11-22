# Coursera Data Science Specialization
# Getting and Cleaning Data Course
# Assignment 1

# Points to where the unzipped data is
extractDir <- "./"
dataDir <- paste0(extractDir, "UCI HAR Dataset")

mergeDataSets <- function(type) {
  trainData <- read.table(paste0(dataDir, "/train/", type, "_train.txt"))
  testData <- read.table(paste0(dataDir, "/test/", type, "_test.txt"))
  
  # Checks if both datasets contain the same number of variables
  if (ncol(trainData) != ncol(testData)) stop("Something is wrong with the data")
  
  mergedData <- rbind(trainData, testData)
  
  if (nrow(mergedData) != nrow(trainData) + nrow(testData)) stop("Something is wrong with merge")
  
  mergedData
}

# 1 - Merges the training and the test sets to create one data set.
  trainData <- read.table(paste0(dataDir, "/train/X_train.txt"))
  testData <- read.table(paste0(dataDir, "/test/X_test.txt"))

  # Checks if both datasets contain the same number of variables
  if (ncol(trainData) != ncol(testData)) stop("Something is wrong with the data")

  mergedData <- rbind(trainData, testData)

  if (nrow(mergedData) != nrow(trainData) + nrow(testData)) stop("Something is wrong with merge")


# 2 - Extracts only the measurements on the mean and standard
#     deviation for each measurement
  # Loads the features list
  features <- read.table(paste0(dataDir, "/features.txt"))

  # Drops the first collumn of the features dataset since it adds nothing new
  features[,1] <- NULL

  # Gives a more descriptive name to the single column in the geatures dataset
  names(features) <- "name"

  # Looks for the features that are a mean or a standard deviation
  colsToExtract <- grep("mean|std", features$name)

  # Sets the variable names for the dataset
  names(mergedData) <- features$name

  # Extracts only the mean and std measurements
  extractedData <- mergedData[,colsToExtract]

# 3 - Uses descriptive activity names to name the activities in the data set
# First merge the train and test activity data
trainActData <- read.table(paste0(dataDir, "/train/y_train.txt"))
testActData <- read.table(paste0(dataDir, "/test/y_test.txt"))

# Checks if both datasets contain the same number of variables
if (ncol(trainActData) != ncol(testActData)) stop("Something is wrong with the ActData data")

mergedActData <- rbind(trainActData, testActData)

if (nrow(mergedActData) != nrow(trainActData) + nrow(testActData)) stop("Something is wrong with ActData merge")

names(mergedActData) <- "activity"

# Reads the activities descriptive labels
activityLabels <- read.table(paste0(dataDir, "/activity_labels.txt"))

mergedActData$activityLabel <- factor(mergedActData$activity, labels=activityLabels[,2])

# Sanity checks to make sure the factor levels match the activity labels
tapply(mergedActData$activity, mergedActData$activityLabel, FUN=mean)
# Another interesting way of checking the levels and labels
table(mergedActData)


# 4 - Appropriately labels the data set with descriptive variable names. 
# Merges the subject data from train and test data sets
trainSubjectData <- read.table(paste0(dataDir, "/train/subject_train.txt"))
testSubjectData <- read.table(paste0(dataDir, "/test/subject_test.txt"))

# Checks if both datasets contain the same number of variables
if (ncol(trainSubjectData) != ncol(testSubjectData)) stop("Something is wrong with the SubjectData data")

mergedSubjectData <- rbind(trainSubjectData, testSubjectData)

if (nrow(mergedSubjectData) != nrow(trainSubjectData) + nrow(testSubjectData)) stop("Something is wrong with SubjectData merge")

names(mergedSubjectData) <- "subject"

# Merges the columns of the main extracted columns data set 
# with the activity labels and subject

if (nrow(extractedData) != nrow(mergedActData) | 
    nrow(extractedData) != nrow(mergedSubjectData)) {
  stop("Number of rows do not match between datasets")
}

tidyDataSet1 <- cbind(extractedData, mergedActData, mergedSubjectData)

# 5 - From the data set in step 4, creates a second, independent 
#     tidy data set with the average of each variable for each 
#     activity and each subject.

library(reshape2)
meltedData <- melt(tidyDataSet1, id.vars=c("subject", "activityLabel"))
tidyDataSet2 <- dcast(meltedData, subject + activityLabel ~ variable, mean)

write.table(tidyDataSet2, file = "tidydata.txt", row.names=FALSE)

# Runs each analysis function

# step1()
# step2()
