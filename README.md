The run_analysis.R script load the training and testing dataset and combine them to create one dataset. It then createsa second, independent tidy data set with the average of each variable for each activity and each subject. For more details please look at the comments in the script.

### 1. load training and test data set and combine them to create the whole dataset
 load feature data for the training set


 load feature data for the test set

 row bind the feature set for the training data set and the test data set to the feature set for the whole dataset


 read the feature names  from the file features.txt


 use the grep function to  find indexes of feature names that contain "mean" or "Mean" or "std"


 extract columns of features that has mean, Mean, or std in their names


 build the whole dataset with mean and std features plus subject and activity columns 


 set the names for columns in the whole dataset


### 2. use the aggregation function to calculate the average tidy data set
