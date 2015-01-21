## getting-cleaning-data-project
#### Repository of codes and instructions for the "Getting and Cleaning Data" Coursera course project.
-------------------------------------------

1. How to run the analysis?
   * Ensure the R-script "run_analysis.R" and the data folder ("UCI HAR Dataset" - download and extracted from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip") are located in the same folder.
   * Set the current working directory to the folder where the R-script and the data reside
   * Run the code by "source" in the R-script

2. Output:
   * Upon successful execution, the "tidyData" object will contain an independent tidy data set with the average of each variable for each activity and each subject

3. The R-script "run_analysis.R" does the following steps in sequence:
   * It first reads in test, training, activities, and subject data sets
   * Assign descriptive activity names to activities inside the test and train data sets
   * Label the data sets' headers with descriptive variable names
   * Merge test and training sets into a joint data set along with their corresponding activities and subjects
   * Extracts only the measurements on the mean and standard deviation for each measurement
   * From the joint data set, to create a second, independent tidy data set with the average of each variable by each activity and each subject

