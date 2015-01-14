#the zip file is unzip into the working directory

# load all the data
wdpath <- getwd()
fpath <- paste(wdpath,"/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", sep="")
x_test <- read.table(file = fpath, header = FALSE)

fpath <- paste(wdpath,"/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", sep="")
x_train <- read.table(file = fpath, header = FALSE)

fpath <- paste(wdpath,"/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", sep="")
y_test <- read.table(file = fpath, header = FALSE)

fpath <- paste(wdpath,"/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", sep="")
y_train <- read.table(file = fpath, header = FALSE)

fpath <- paste(wdpath,"/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", sep="")
subject_test <- read.table(file = fpath, header = FALSE)

fpath <- paste(wdpath,"/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", sep="")
subject_train <- read.table(file = fpath, header = FALSE)

fpath <- paste(wdpath,"/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", sep="")
activity_labels <- read.table(file = fpath, header = FALSE)

fpath <- paste(wdpath,"/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt", sep="")
features <- read.table(file = fpath, header = FALSE,)

# merge test and training and select the relevant columns

features <- as.character(features[,2])
library(stringr)
feattokeep1 <- str_detect(features, "mean()")
feattokeep2 <- str_detect(features, "std()")
feattokeep <- feattokeep1 | feattokeep2

x_data <- rbind(x_train, x_test)
colnames(x_data) <- features
x_data <- x_data[, feattokeep]

# add subject and activity columns
y_data <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
x_data$subject <- subject[,1]

library(dplyr)
y_data <- left_join(y_data, activity_labels)
x_data$activity <- y_data[,2]
rm(list = c("x_train", "x_test", "y_train", "y_test", "subject_train", "subject_test", "y_data", "subject"))

# create the summary, tidy summary
x_data_summary <- x_data %>% group_by(subject, activity) %>% summarise_each(funs(mean), 1:(dim(x_data)[2]-2))
write.table(x_data_summary, file="x_data_summary.txt", row.names=FALSE)
