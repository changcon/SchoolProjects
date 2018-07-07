## grab the subject_test.txt which has the subject ID
## grab the X_train.txt which has the test set
## grab the y_train.txt which has the test label
## grab features.txt which has the list of all features

## subject_test is a dataframe with dim 2947 x 1, containing 9 subject IDs
## test_set is a dataframe with dim 2947 x 561, containing variable values
## test_labels is a dataframe with dim 2947 x 1, containing 6 activity IDs
## features is a dataframe of 561 x 2, containing variable names

subject_test=read.table("C:\\Users\\ub67350\\Documents\\getdata%2Fprojectfiles%2FUCI HAR Dataset (1)\\UCI HAR Dataset\\test\\subject_test.txt")
test_set=read.table("C:\\Users\\ub67350\\Documents\\getdata%2Fprojectfiles%2FUCI HAR Dataset (1)\\UCI HAR Dataset\\test\\X_test.txt")
test_labels=read.table("C:\\Users\\ub67350\\Documents\\getdata%2Fprojectfiles%2FUCI HAR Dataset (1)\\UCI HAR Dataset\\test\\y_test.txt")
features=read.table("C:\\Users\\ub67350\\Documents\\getdata%2Fprojectfiles%2FUCI HAR Dataset (1)\\UCI HAR Dataset\\features.txt")

##add variable names to test_set's colnames

variableNames <- features[,2]
colnames(test_set)<-variableNames

##cbind two additional columns to test_set -- VolunteerID and ActivityID --
## and add their variable names to test_set's colnames 

colnames(subject_test) <- "VolunteerSubjectID"
colnames(test_labels) <- "ActivityID"

test_set<-cbind(test_set,subject_test)
test_set<-cbind(test_set,test_labels)

## Similarly for the training set...

subject_train=read.table("C:\\Users\\ub67350\\Documents\\getdata%2Fprojectfiles%2FUCI HAR Dataset (1)\\UCI HAR Dataset\\train\\subject_train.txt")
train_set=read.table("C:\\Users\\ub67350\\Documents\\getdata%2Fprojectfiles%2FUCI HAR Dataset (1)\\UCI HAR Dataset\\train\\X_train.txt")
train_labels=read.table("C:\\Users\\ub67350\\Documents\\getdata%2Fprojectfiles%2FUCI HAR Dataset (1)\\UCI HAR Dataset\\train\\y_train.txt")

variableNames <- features[,2]
colnames(train_set)<-variableNames

colnames(subject_train) <- "VolunteerSubjectID"
colnames(train_labels) <- "ActivityID"

train_set<-cbind(train_set,subject_train)
train_set<-cbind(train_set,train_labels)

## append the test_set and train_set together

TrainTestData <- rbind(train_set,test_set)

## check for mean() and std in the colnames
## and pick out just the mean and std variables from the dataset

grep("mean\\(\\)",colnames(TrainTestData),value=TRUE)
grep("std",colnames(TrainTestData),value=TRUE)

meanstd_index<-unique(c(grep("mean\\(\\)",colnames(TrainTestData)), grep("std",colnames(TrainTestData)), grep("ID",colnames(TrainTestData))))
TrainTestData<-TrainTestData[,meanstd_index]

#create a second dataset with the average of each variable by activity/subject combo
TrainTestDataGrouped<-group_by(TrainTestData,VolunteerSubjectID,ActivityID)

TrainTestMeans -> summarize_if(TrainTestDataGrouped,is.numeric, funs(mean), na.rm = TRUE)

#add activity labels
TrainTestMeans$ActivityID <- recode(TrainTestMeans$ActivityID, '1'= "Walking", '2' = "Walking_Upstairs", '3' = "Walking_Downstairs", '4' = "Sitting", '5' = "Standing", '6' = "Laying")

write.txt(TrainTestMeans,"TrainTestMeans.txt",row.names=FALSE)