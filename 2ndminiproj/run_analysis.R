filename<-"UCI HAR Dataset.zip"
if(!file.exists(filename)){
  file<-"http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip"
  download.file(file,filename,method="curl")
}
if(!file.exists("UCI HAR Dataset")){
  unzip(filename)
}

## features and activity
features<-read.table("UCI HAR Dataset/features.txt")
activity<-read.table("UCI HAR Dataset/activity_labels.txt")

## test data:
XTest<- read.table("UCI HAR Dataset/test/X_test.txt")
YTest<- read.table("UCI HAR Dataset/test/Y_test.txt")
SubjectTest <-read.table("UCI HAR Dataset/test/subject_test.txt")

## train data:
XTrain<- read.table("UCI HAR Dataset/train/X_train.txt")
YTrain<- read.table("UCI HAR Dataset/train/Y_train.txt")
SubjectTrain <-read.table("UCI HAR Dataset/train/subject_train.txt")


##Part1 - merges train and test data in one dataset (full dataset at the end)
X<-rbind(XTest, XTrain)
Y<-rbind(YTest, YTrain)
Subjects<-rbind(SubjectTest, SubjectTrain)


index<-grep("mean\\(\\)|std\\(\\)", features[,2]) ##getting features indeces which contain mean() and std() in their name

X<-X[,index] ## getting only variables with mean/stdev

Y[,1]<-activity[Y[,1],2] ## replacing numeric values with lookup value from activity.txt; won't reorder Y set
##         V1
## 1 STANDING

names<-features[index,2] ## getting names for variables

names(X)<-names ## updating colNames for new dataset
names(Subjects)<-"SubjectID"
names(Y)<-"Activity"

CleanedData<-cbind(Subjects, Y, X)

CleanedData<- data.table::data.table(CleanedData)

TidyData <- CleanedData[, lapply(.SD, mean), by = 'SubjectID,Activity'] 

write.table(TidyData, file = "TidyData.txt", row.names = FALSE)

head(TidyData[order(SubjectID)][,c(1:4), with = FALSE],12) 
