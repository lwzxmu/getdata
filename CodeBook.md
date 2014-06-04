run_analysis.R
====================
THIS IS THE CODEBOOK OF THE COURSE PROJECT OF GETTING AND CLEANING DATA, DATA SCIENCE TRACK

BRIEF SUMMARY ABOUT HOW THE SCRIPT WORKS:

The script reads all the datasets from various files given and stores them in variables.
The script then adds the labels of rows in the features.txt and using appropriate values.
It then adds columns for the subject and activity and assigns appropriate headers
It combines both train and test tables into one and finally replaces data in activity column with descriptive activity.
It converts itself in data.table and uses lapply to create independent tidy data set with the average of each variable for each activity and each subject.

Note: The working directory is UCI_HAR_Dataset as downloaded directly from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

====================
ADDITIONAL PACKAGES APPLIED:

plyr;
reshape;
reshape2;

R VERSION:

R 3.1.0 X64

IDE VERSION:
Rstudio 0.98.507
====================
##load features and activitylabels as tthe first row of the dataset
activity.labels <- read.table("./activity_labels.txt");
features <- read.table("./features.txt");

#load variables of test group
x.test <- read.table("./test/X_test.txt");
y.test <- read.table("./test/Y_test.txt");
subject.test <- read.table("./test/subject_test.txt");

#load variable of train group
x.train <- read.table("./train/X_train.txt");
y.train <- read.table("./train/y_train.txt");
subject.train <- read.table("./train/subject_train.txt");

#merge the 4train and test datasets subjects
subjects <- rbind(subject.test , subject.train);
colnames(subjects) <- "subjects";

#merge the labels of train and test subjects
labels <- rbind(y.test,y.train);
labels <- merge(labels, activity.labels, by="V1")[,2]

#merge the set of test and train sbjts
data <- rbind(x.test,x.train);
colnames(data) <- features[,2];

#merge the three datasets
data <- cbind(subjects, labels, data);

#search the variable names contains "mean" || "std
dummy <- grep("[Mm][Ee][Aa][Nn]|[Ss][Tt][Dd]",colnames(data));
data.mean.std <- data[,c(1,2,dummy)];

#compute the means, grouped by subject and label
melted <- melt(data.mean.std, id.var = c("subjects", "labels"));
avg <- dcast(melted , subjects + labels ~ variable, mean);

#save result
write.table(avg, file="./tidy_data.txt");

#output result
head(avg);
