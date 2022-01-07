# How to Run run_analysis.R

by Rose Melena M. Amarillo

## Inroduction
- Line 1 to Line 8 prioritizes the download the zip file of **UCI HAIR DATASET**.
  -  First condition: If the zip file doesn't exist it will upload the into your current directory.
  - Second condition: If **UCI HAIR DATASET** doesn't exist, it will unzip the downloaded zip file.

### The script follows the condition given by our instructor:
  - Merges the training and the test sets to create one data set.
  - Extracts only the measurements on the mean and standard deviation for each measurement
  - Uses descriptive activity names to name the activities in the dataset
  - Appropriately labels the data set with descriptive variable names
  - From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.


>For the first part, before merging the test and train sets to one data set, first I read the table of each file (one-by-one) and set it to different variables. Part one is met when I use the rbind function in merging two data sets in one at line 28. 

>For part two, I use indexing to determine names/variables with mean and std alone. First, indexing, I use grep function in finding items that contain mean() and std() in their name in file "features.txt" but using the dataset "features". I put variables with mean and std on its name inside X.

>For part three, replacing numeric labels of activity in column 2 of the data frame (from 1 to 6) by descriptive strings which come from the file activity.txt.

>For part four, labeling the data set with descriptive variable, I use features in getting names for variables. Next, update the colNames for new data set. Then use cbind to combine vectors under each variables in columns to easy use it for data.table.

>For part five, creating independent tidy data set with the average of each variable for each activity and each subject using data.table and lapply. Then write it on another text file which is the TidyData.txt for output. Lastly, it outputs 12 rows of the TidyData.

Thank you! <3