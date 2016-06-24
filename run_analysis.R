# function to check if a package is installed
pckCheck <- function(x)
{
  if (!require(x,character.only = TRUE))
  {
    install.packages(x,dep=TRUE)
    if(!require(x,character.only = TRUE)) stop("Package not found")
  }
  library(x, character.only = TRUE)
}

# install and call libraries
pckCheck("stringr")
pckCheck("dplyr")
pckCheck("reshape")
pckCheck("plyr")

# download sources
if (!file.exists("./dataset.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","./dataset.zip")
}
if (!file.exists("./UCI HAR Dataset/")) {
  unzip("./dataset.zip")
}

# Load sources
setwd("./UCI HAR Dataset/")
sources <- c("features.txt","activity_labels.txt","test/X_test.txt","test/y_test.txt","test/subject_test.txt","train/X_train.txt","train/y_train.txt","train/subject_train.txt")
for(i in sources){ 
  #put in a variable the file's name, 
  #load the file, 
  #change the variable's name by the file's name
  #ex : the file features.txt is loaded in a variable features
  n <- basename(i)
  n <- substr(n, 1, str_length(n)-4)
  x <- read.table(i)
  assign(n,x)
}

# Assign columns's name
features[,2] <- gsub("[(][)]","1",features[,2])
colnames(X_test) <- features[,2]
colnames(X_train) <- features[,2]
colnames(y_test) <- "Activity"
colnames(y_train) <- "Activity"
colnames(subject_test) <- "Subject"
colnames(subject_train) <- "Subject"
colnames(activity_labels) <- c("level","label")

# Merge files test and train
data_test <- cbind(subject_test, y_test, X_test)
data_train <- cbind(subject_train, y_train, X_train)
data <- rbind(data_test,data_train)

# Make valid column's names 
valid_column_names <- make.names(names=names(data), unique=TRUE, allow_ = TRUE)
names(data) <- valid_column_names

# Replace Activity level by activity name
data <- merge(data,activity_labels,by.x = "Activity",by.y = "level")

# Extract columns Suject Activity, that contains mean1 (in original file it was mean()) and contains std1
data <- select(data, Subject, Activity = label, contains("mean1"), contains("std1"))

# Calculate average of all columns for each Subject/Activity
data_avg <- data %>% group_by(Subject,Activity) %>% summarise_each(funs(mean))

setwd("../")

# Export the result frame in text file
if (file.exists("./tidy_data.txt")) {
  file.remove("./tidy_data.txt")
}
write.table(data,"tidy_data.txt")

# Export the result frame in text file
if (file.exists("../tidy_data_avg.txt")) {
  file.remove("./tidy_data_avg.txt")
}
write.table(data_avg,"tidy_data_avg.txt")