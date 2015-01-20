library(data.table)
# read-in test, training, activities, and subject data sets
testData <- read.table("./UCI-HAR-Dataset/test/X_test.txt",header=FALSE)
testData_act <- read.table("./UCI-HAR-Dataset/test/y_test.txt",header=FALSE)
testData_sub <- read.table("./UCI-HAR-Dataset/test/subject_test.txt",header=FALSE)
trainData <- read.table("./UCI-HAR-Dataset/train/X_train.txt",header=FALSE)
trainData_act <- read.table("./UCI-HAR-Dataset/train/y_train.txt",header=FALSE)
trainData_sub <- read.table("./UCI-HAR-Dataset/train/subject_train.txt",header=FALSE)

# Assign descriptive activity names to activities inside the test and train data sets
activities <- read.table("./UCI-HAR-Dataset/activity_labels.txt",header=FALSE,colClasses="character")
testData_act$V1 <- factor(testData_act$V1,levels=activities$V1,labels=activities$V2)
trainData_act$V1 <- factor(trainData_act$V1,levels=activities$V1,labels=activities$V2)

# Label the data sets' headers with descriptive variable names
features <- read.table("./UCI-HAR-Dataset/features.txt",header=FALSE,colClasses="character")
colnames(testData)<-features$V2
colnames(trainData)<-features$V2
colnames(testData_act)<-c("Activity")
colnames(trainData_act)<-c("Activity")
colnames(testData_sub)<-c("Subject")
colnames(trainData_sub)<-c("Subject")

# Merge test and training sets into a joint data set along with
# their corresponding activities and subjects
testData<-cbind(testData,testData_act)
testData<-cbind(testData,testData_sub)
trainData<-cbind(trainData,trainData_act)
trainData<-cbind(trainData,trainData_sub)
jointData<-rbind(testData,trainData)

# Extracts only the measurements on the mean and 
# standard deviation for each measurement
jointData_mean<-sapply(jointData,mean,na.rm=TRUE)
jointData_sd<-sapply(jointData,sd,na.rm=TRUE)

# From the joint data set, to create a second, independent tidy data set 
# with the average of each variable for each activity and each subject
dt<- data.table(jointData)
tidyData<-dt[,lapply(.SD,mean),by="Activity,Subject"]
