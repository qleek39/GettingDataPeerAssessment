
# load feature data for the training set
train.df <- read.table(file = 'UCI HAR Dataset/train/X_train.txt', header = FALSE)
# load feature data for the test set
test.df <- read.table(file = 'UCI HAR Dataset/test/X_test.txt', header = FALSE)
train.subject.df <- read.table(file = 'UCI HAR Dataset/train/subject_train.txt', header = FALSE)
test.subject.df <- read.table(file = 'UCI HAR Dataset/test/subject_test.txt', header = FALSE)
train.activity.df <- read.table(file = 'UCI HAR Dataset//train//y_train.txt', header = FALSE)
test.activity.df <- read.table(file = 'UCI HAR Dataset/test/y_test.txt', header = FALSE)

train.set.df <- cbind(train.df, train.subject.df, train.activity.df)
test.set.df <- cbind(test.df, test.subject.df, test.activity.df)


# row bind the feature set for the training data set and the test data set to the feature set for the whole dataset
dataset.feature.df <- rbind(train.df, test.df)

train.subject.activity.df <- cbind(train.subject.df, train.activity.df)
test.subject.activity.df <- cbind(test.subject.df, test.activity.df)
# the data frame contains two columns subject and activity of the whole dataset
dataset.subject.activity.df <- rbind(train.subject.activity.df, test.subject.activity.df)

# read the feature names 
feature.names <- readLines('UCI HAR Dataset/features.txt')

# find indexes of feature names that contain "mean" or "Mean" or "std"
mean.n.std.idxs <- grep('mean|Mean|std', feature.names)

# extract columns of features that has mean, Mean, or std in their names
dataset.chosen.feature.df <- dataset.feature.df[, mean.n.std.idxs]

# the whole dataset with mean and std features plus subject and activity columns 
dataset.df <- cbind(dataset.chosen.feature.df, dataset.subject.activity.df)

# set names for the columns
chosen.feature.names <- feature.names[mean.n.std.idxs]

# set names for all columns in the dataset
colnames(dataset.df) <- c(chosen.feature.names, 'subject', 'activity')
# colnames(dataset.df)

# calculate the second average tidy dataset
attach(dataset.df)

average.tidy.dataset.df <- aggregate(dataset.df, by = list(subject, activity), FUN = mean )
colnames(average.tidy.dataset.df)
average.tidy.dataset.df <- average.tidy.dataset.df[, 3:length(colnames(average.tidy.dataset.df))]

# change names of the feature variables to Average plus the old name
colnames(average.tidy.dataset.df)[1:(length(average.tidy.dataset.df)-2)] <- paste0('Average-', chosen.feature.names)


# write the second average tidy dataset to the text file
write.table(average.tidy.dataset.df, 'average.tidy.dataset.txt')
