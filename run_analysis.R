# downloading data. 
## Url address and download files, zip file named projectData. 
dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataUrl,"../R/projectData.zip", 
              method = "curl")

files.temp <- "projectData.zip"
unzip("projectData.zip")
for (i in files.temp)unzip(i)


# read training data, x, y, and subjects
library(data.table)
x_train <- read.table("../R/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("../R/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("../R/UCI HAR Dataset/train/subject_train.txt")

# read test data, 
x_test <- read.table("../R/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("../R/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("../R/UCI HAR Dataset/test/subject_test.txt")

# read feature and activities
features <- read.table('../R/UCI HAR Dataset/features.txt')
activity_label <- read.table('../R/UCI HAR Dataset/activity_labels.txt')


colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activity_label) <- c('activityId','activityType')


# merging data
train <- cbind(y_train, subject_train, x_train)
test <- cbind(y_test, subject_test, x_test)
total <- rbind(train, test)
head(total)

# select the variable of interests
colNames <- colnames(total)

col_filter <- (grepl("activityId" , colNames) | 
                         grepl("subjectId" , colNames) | 
                         grepl("mean.." , colNames) | 
                         grepl("std.." , colNames) 
)


#subsetting
total_sub <- total[ , col_filter == TRUE]
ncol(total_sub)

# rename activities
total_sub_actname <- merge(total_sub, activity_label,
                              by='activityId',
                              all.x=TRUE)
head(total_sub_actname)
names(total_sub_actname)

# new data set with mean of each variable. 
newset <- aggregate(. ~subjectId + activityId, total_sub_actname, mean)
newset <- newset[order(total_sub_actname$subjectId,total_sub_actname$activityId),]
