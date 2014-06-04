library(plyr)
library(reshape)
library(reshape2)

setwd("E:/Rdir/UCI HAR Dataset/");
getwd();

##load features and activitylabels as tthe first row of the dataset
activity.labels <- read.table("./activity_labels.txt");
features <- read.table("./features.txt");

##load variables of test group
x.test <- read.table("./test/X_test.txt");
y.test <- read.table("./test/Y_test.txt");
subject.test <- read.table("./test/subject_test.txt");

##load variable of train group
x.train <- read.table("./train/X_train.txt");
y.train <- read.table("./train/y_train.txt");
subject.train <- read.table("./train/subject_train.txt");

##merge the 4train and test datasets subjects
subjects <- rbind(subject.test , subject.train);
colnames(subjects) <- "subjects";

##merge the labels of train and test subjects
labels <- rbind(y.test,y.train);
labels <- merge(labels, activity.labels, by="V1")[,2]

##merge the set of test and train sbjts
data <- rbind(x.test,x.train);
colnames(data) <- features[,2];

##merge the three datasets
data <- cbind(subjects, labels, data);

##search the variable names contains "mean" || "std
dummy <- grep("[Mm][Ee][Aa][Nn]|[Ss][Tt][Dd]",colnames(data));
data.mean.std <- data[,c(1,2,dummy)];

##compute the means, grouped by subject and label
melted <- melt(data.mean.std, id.var = c("subjects", "labels"));
avg <- dcast(melted , subjects + labels ~ variable, mean);

##save result
write.table(avg, file="./tidy_data.txt");

##output result
head(avg);
