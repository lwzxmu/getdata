run_analysis.R
=======
#########################################################################################
THIS IS THE README OF THE COURSE PROJECT OF GETTING AND CLEANING DATA, DATA SCIENCE TRACK

The comments in the script sufficiently explains how the script works. However, here's the general summary:

    The script reads all necessary data from various files given and stores them in relevant variables.
    The script then adds labels by transposing the rows in the features.txt and using appropriate values.
    It then adds columns for the subject and activity and assigns appropriate headers
    It combines both train and test tables into one and finally replaces data in activity column with descriptive activity.
    Finally, it converts itself in data.table and uses lapply to create independent tidy data set with the average of each variable for each activity and each subject.

Note: The working directory is UCI_HAR_Dataset as downloaded directly from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

CodeBook.md contains the code with appropriate comments. 
