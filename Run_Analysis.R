#### Getting and Cleaning data


### Request (1) 

if(!dir.exists("Assignment")){dir.create("Assignment")}

###

X_test <- read.table("Assignment/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("Assignment/UCI HAR Dataset/test/y_test.txt")
test_Subjects <- read.table("Assignment/UCI HAR Dataset/test/subject_test.txt")


X_train <- read.table("Assignment/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("Assignment/UCI HAR Dataset/train/y_train.txt")
train_Subjects <- read.table("Assignment/UCI HAR Dataset/train/subject_train.txt")


### Merge  data

merge_data1 <- cbind(y_test, test_Subjects, X_test)
merge_data2 <- cbind(y_train,train_Subjects, X_train)
merge_all_data <- rbind(merge_data1 , merge_data2 )

### Request (2) 
features <- read.table("Assignment/UCI HAR Dataset/features.txt")
features_statictic <- grep(".*mean.*|.*std.*", features[,2])
features_statictic <- features[features_statictic,2]
features_statictic = gsub('-mean', 'Mean', features_statictic)
features_statictic = gsub('-std', 'Std', features_statictic)
features_statictic <- gsub('[-()]', '', features_statictic)

### Request (4) 

colnames(merge_all_data) <- c("activity", "subject",  features_statictic)

### Request (3) 

activity <- read.table("Assignment/UCI HAR Dataset/activity_labels.txt")
merge_all_data$activity <- factor(merge_all_data$activity, levels = activity[,1], labels = activity[,2])
merge_all_data$subject <- as.factor(merge_all_data$subject)

###  Request (5) 
library(reshape2)
merge_all_data.melt <- melt(merge_all_data, id = c("activity","subject"))
merge_all_data.mean <- dcast(merge_all_data.melt, activity+subject ~ variable, mean)

write.table(merge_all_data.mean, "tidy_dataset.txt", row.names = FALSE)
