# CodeBook
## Coursera Data Science Specialization
### Getting and Cleaning Data
> WARNING: If the file you are seeing has the .Rmd extension you should go to [CodeBook.md](https://github.com/hlm/DS03-ProgrammingAssignment1/blob/master/CodeBook.md)

Describes the variables, the data, and any transformations or work that you performed to clean up the data

## Raw data
The data can be automatically downloaded and unzip by the `get_data.R` script. Once extracted you will find 
a series of files under the `UCI HAR Dataset` directory, the `README.txt` file describes the content for each one
of the files in the directory.

This data set holds information about the accelerometer and gyroscope sensors of a Samsung phone as 30 subjects carried
on regular activities during the day. The data is divided into two sub-sets, one for training and one for testing, these
datasets were sampled randomly for the purposes of training and testing machine learning algorithms.

## Analysis
The analysis has a clear objective in mind as instructed by the assessment, it followed a phased approach to produce
the desired outcome in the form of a file that can be read by R containing the desired variables.

The first step of the analysis takes care of merging the individual subsets for training and testing. A simple
`rbind` was used to concatenate the two datasets together, worth noting that, because merging the training and
testing datasets was a reusable piece of functionallity, because there are other training and test files pertaining to
the same observation, it was implemented as a function that could be reused when merging training and test datasets
for other observed variables.

In the second step it finds the variables we are interested in the full range of feature variables available 
(there 561 available variables). The variables of interest are the mean and the standard deviation of the 
multitude of readings from the mobile sensors. The approach for finding the variables uses the `grep` function to 
identify the presence of either the word "mean" or "std" in the variable name to then use the indexes of where 
these character strings were found to select just the columns of interest from the merged dataSet create on the first phase.
The variable selection process brought down the number of variables to 81, all of which are properly described at the
bottom of this page.

In the third step, activity data for the training and test dataset are merged using the same function used in step 1 but with
different input data. Because the activity data is coded by a number for which activity names described are defined 
in the file `activity_labels.txt` that file is read and a new variable called `activityLabel` is created in the 
merged activity data frame that is a factor of the existing activity code leveled by the names defined in 
`activity_labels.txt`, in effect this creates a variable that displays as human readable description of the 
activity observed, e.g., walking, sitting, standing etc, but that is internally stored as a code that matches the 
original definitions found in the raw training and test acitivity datasets, e.g., waking is coded as activity 1.

Still in step three, to make sure that the new factor variable was equivalent to the original 
numeric coding of the raw data, I used a table to inspect the distribution of the factors and the original 
activity numeric codes as shown bellow:




```r
mergedActData <- mergeDataSets("y")

names(mergedActData) <- "activity"

# Reads the activities descriptive labels
activityLabels <- read.table(paste0(dataDir, "/activity_labels.txt"))

mergedActData$activityLabel <- factor(mergedActData$activity, labels=activityLabels[,2])

# Checks the levels and labels, see if nothing was wronging coded into factors
table(mergedActData)
```

```
##         activityLabel
## activity WALKING WALKING_UPSTAIRS WALKING_DOWNSTAIRS SITTING STANDING
##        1    1722                0                  0       0        0
##        2       0             1544                  0       0        0
##        3       0                0               1406       0        0
##        4       0                0                  0    1777        0
##        5       0                0                  0       0     1906
##        6       0                0                  0       0        0
##         activityLabel
## activity LAYING
##        1      0
##        2      0
##        3      0
##        4      0
##        5      0
##        6   1944
```

In step four subject data is merged across the training and test datasets using the merge function introduced before. The subject
data is numerical and fairly trivial, so no further processing was necessary of that particular data. Finally, a new merge was performed,
this time a merge of collumns using `cbind` combining the datasets composed of the actual measurements, the activity names and
the subject for each observation. A total of 10299 observation were merged from the training and test datasets.

Step five concluded the analysis by aggregating all the 81 variables by subject and activity using the `mean` function. The approach
to aggregate the data took advantage of the `reshape2` package by first meling the dataset using subject and activity name as ids
then casting the data back to wide format while applying the `mean` function. The reshaped data was stored in an entire new variable
by the name `tidyDataSet2`, this variable was then written to disk as a text file named `tidydata.txt` by using the 
`write.table()` function.

Beyond the analysis steps, I create a quick test function that is able to compare the expected md5 hash for the `tidydata.txt` against
the output of the analysis. Understandly, I could have the wrong answer to begin with and my hash would not be worth anything, however
being able to capture a hash of my first, hopefully correct, answer and then make changes to the analysis script knowning that if I broke anything that was "working before" was a great help and good overall software development practice. This test script is 
called `test_result.R` and contains the a hardcoded md5 hash of what I think is the right answer.


```r
library(digest)
expectedMd5 <- "8161c06dbe59f0131a5840917d275feb"
data <- read.table("tidydata.txt")
md5 <- digest(data, serialize=TRUE)
if(identical(md5,expectedMd5)) print(paste('Test PASSED', md5))
```

```
## [1] "Test PASSED 8161c06dbe59f0131a5840917d275feb"
```

## Variables
Bellow you will find an exhaustive list of the variables found in the tidy data set resulting from the analysis performed by `run_analysis.R`


|variable                         |Domain     |Description                                                                                               |
|:--------------------------------|:----------|:---------------------------------------------------------------------------------------------------------|
|subject                          | NA        |The identifier of the subject who carried out the experiment                                              |
|activityLabel                    | NA        |The activity name for this observation                                                                    |
|tBodyAcc-mean()-X                | Time      |The mean of Body Acceleration on the x-axis                                                               |
|tBodyAcc-mean()-Y                | Time      |The mean of Body Acceleration on the y-axis                                                               |
|tBodyAcc-mean()-Z                | Time      |The mean of Body Acceleration on the z-axis                                                               |
|tBodyAcc-std()-X                 | Time      |The standard deviation of Body Acceleration on the x-axis                                                 |
|tBodyAcc-std()-Y                 | Time      |The standard deviation of Body Acceleration on the y-axis                                                 |
|tBodyAcc-std()-Z                 | Time      |The standard deviation of Body Acceleration on the z-axis                                                 |
|tGravityAcc-mean()-X             | Time      |The mean of Gravity Acceleration on the x-axis                                                            |
|tGravityAcc-mean()-Y             | Time      |The mean of Gravity Acceleration on the y-axis                                                            |
|tGravityAcc-mean()-Z             | Time      |The mean of Gravity Acceleration on the z-axis                                                            |
|tGravityAcc-std()-X              | Time      |The standard deviation of Gravity Acceleration on the x-axis                                              |
|tGravityAcc-std()-Y              | Time      |The standard deviation of Gravity Acceleration on the y-axis                                              |
|tGravityAcc-std()-Z              | Time      |The standard deviation of Gravity Acceleration on the z-axis                                              |
|tBodyAccJerk-mean()-X            | Time      |mean Body linear acceleration derived in time (Jerk) on the x-axis                                        |
|tBodyAccJerk-mean()-Y            | Time      |mean Body linear acceleration derived in time (Jerk) on the y-axis                                        |
|tBodyAccJerk-mean()-Z            | Time      |mean Body linear acceleration derived in time (Jerk) on the z-axis                                        |
|tBodyAccJerk-std()-X             | Time      |standard deviation of Body linear acceleration derived in time (Jerk) on the x-axis                       |
|tBodyAccJerk-std()-Y             | Time      |standard deviation of Body linear acceleration derived in time (Jerk) on the y-axis                       |
|tBodyAccJerk-std()-Z             | Time      |standard deviation of Body linear acceleration derived in time (Jerk) on the z-axis                       |
|tBodyGyro-mean()-X               | Time      | mean of body angular velocity on the x-axis                                                              |
|tBodyGyro-mean()-Y               | Time      | mean of body angular velocity on the y-axis                                                              |
|tBodyGyro-mean()-Z               | Time      | mean of body angular velocity on the z-axis                                                              |
|tBodyGyro-std()-X                | Time      | standard deviation of body angular velocity on the x-axis                                                |
|tBodyGyro-std()-Y                | Time      | standard deviation of body angular velocity on the y-axis                                                |
|tBodyGyro-std()-Z                | Time      | standard deviation of body angular velocity on the z-axis                                                |
|tBodyGyroJerk-mean()-X           | Time      | mean jerk signal of body angular velocity on the x-axis                                                  |
|tBodyGyroJerk-mean()-Y           | Time      | mean jerk signal of body angular velocity on the y-axis                                                  |
|tBodyGyroJerk-mean()-Z           | Time      | mean jerk signal of body angular velocity on the z-axis                                                  |
|tBodyGyroJerk-std()-X            | Time      | standard deviation jerk signal (angular velocity devired in time) of body angular velocity on the x-axis |
|tBodyGyroJerk-std()-Y            | Time      | standard deviation jerk signal (angular velocity devired in time) of body angular velocity on the y-axis |
|tBodyGyroJerk-std()-Z            | Time      | standard deviation jerk signal (angular velocity devired in time) of body angular velocity on the z-axis |
|tBodyAccMag-mean()               | Time      | mean body linear acceleration magnitude calculated using the Euclidean norm                              |
|tBodyAccMag-std()                | Time      | standard deviation of body linear acceleration magnitude calculated using the Euclidean norm             |
|tGravityAccMag-mean()            | Time      | mean gravity linear acceleration magnitude calculated using the Euclidean norm                           |
|tGravityAccMag-std()             | Time      | standard deviation of gravity linear acceleration magnitude calculated using the Euclidean norm          |
|tBodyAccJerkMag-mean()           | Time      | mean body linear acceleration jerk magnitude calculated using the Euclidean norm                         |
|tBodyAccJerkMag-std()            | Time      | standard deviation of body linear acceleration jerk magnitude calculated using the Euclidean norm        |
|tBodyGyroMag-mean()              | Time      | mean body angular velocity magnitude calculated using the Euclidean norm                                 |
|tBodyGyroMag-std()               | Time      | standard deviation body angular velocity magnitude calculated using the Euclidean norm                   |
|tBodyGyroJerkMag-mean()          | Time      | mean body angular velocity jerk magnitude                                                                |
|tBodyGyroJerkMag-std()           | Time      | standard deviation body angular velocity jerk magnitude                                                  |
|fBodyAcc-mean()-X                | Frequency |mean body acceleration on the x-axis                                                                      |
|fBodyAcc-mean()-Y                | Frequency |mean body acceleration on the y-axis                                                                      |
|fBodyAcc-mean()-Z                | Frequency |mean body acceleration on the z-axis                                                                      |
|fBodyAcc-std()-X                 | Frequency |standard deviation body acceleration on the x-axis                                                        |
|fBodyAcc-std()-Y                 | Frequency |standard deviation body acceleration on the y-axis                                                        |
|fBodyAcc-std()-Z                 | Frequency |standard deviation body acceleration on the z-axis                                                        |
|fBodyAcc-meanFreq()-X            | Frequency |Weighted average of the frequency components on the x-axis                                                |
|fBodyAcc-meanFreq()-Y            | Frequency |Weighted average of the frequency components on the y-axis                                                |
|fBodyAcc-meanFreq()-Z            | Frequency |Weighted average of the frequency components on the z-axis                                                |
|fBodyAccJerk-mean()-X            | Frequency |mean body acceleration jerk on the x-axis                                                                 |
|fBodyAccJerk-mean()-Y            | Frequency |mean body acceleration jerk on the y-axis                                                                 |
|fBodyAccJerk-mean()-Z            | Frequency |mean body acceleration jerk on the z-axis                                                                 |
|fBodyAccJerk-std()-X             | Frequency |standard deviation body acceleration jerk on the x-axis                                                   |
|fBodyAccJerk-std()-Y             | Frequency |standard deviation body acceleration jerk on the y-axis                                                   |
|fBodyAccJerk-std()-Z             | Frequency |standard deviation body acceleration jerk on the z-axis                                                   |
|fBodyAccJerk-meanFreq()-X        | Frequency |Weighted average of the frequency components on the x-axis                                                |
|fBodyAccJerk-meanFreq()-Y        | Frequency |Weighted average of the frequency components on the y-axis                                                |
|fBodyAccJerk-meanFreq()-Z        | Frequency |Weighted average of the frequency components on the z-axis                                                |
|fBodyGyro-mean()-X               | Frequency |mean of body angular velocity on the x-axis                                                               |
|fBodyGyro-mean()-Y               | Frequency |mean of body angular velocity on the y-axis                                                               |
|fBodyGyro-mean()-Z               | Frequency |mean of body angular velocity on the z-axis                                                               |
|fBodyGyro-std()-X                | Frequency |standard deviation of body angular velocity on the x-axis                                                 |
|fBodyGyro-std()-Y                | Frequency |standard deviation of body angular velocity on the y-axis                                                 |
|fBodyGyro-std()-Z                | Frequency |standard deviation of body angular velocity on the z-axis                                                 |
|fBodyGyro-meanFreq()-X           | Frequency |Weighted average of the angular velocity frequency components on the x-axis                               |
|fBodyGyro-meanFreq()-Y           | Frequency |Weighted average of the angular velocity frequency components on the y-axis                               |
|fBodyGyro-meanFreq()-Z           | Frequency |Weighted average of the angular velocity frequency components on the z-axis                               |
|fBodyAccMag-mean()               | Frequency |body linear acceleration magnitue mean                                                                    |
|fBodyAccMag-std()                | Frequency |body linear acceleration magnitue standard deviation                                                      |
|fBodyAccMag-meanFreq()           | Frequency |weighted average of the body's linear acceleration frequency components                                   |
|fBodyBodyAccJerkMag-mean()       | Frequency |mean of the body acceleration jerk                                                                        |
|fBodyBodyAccJerkMag-std()        | Frequency |standard deviation of the body acceleration jerk                                                          |
|fBodyBodyAccJerkMag-meanFreq()   | Frequency |weighted average of the body acceleration jerk                                                            |
|fBodyBodyGyroMag-mean()          | Frequency |mean of body angular velocity magnitude                                                                   |
|fBodyBodyGyroMag-std()           | Frequency |standard deviation of body angular velocity magnitude                                                     |
|fBodyBodyGyroMag-meanFreq()      | Frequency |weighted average of angular velocity magnitude                                                            |
|fBodyBodyGyroJerkMag-mean()      | Frequency |mean of angular velocity jerk                                                                             |
|fBodyBodyGyroJerkMag-std()       | Frequency |standard deviation of angular velocity jerk                                                               |
|fBodyBodyGyroJerkMag-meanFreq()  | Frequency |weighted average of angular velocity jerk magnitude                                                       |
