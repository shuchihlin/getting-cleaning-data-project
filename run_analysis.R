library(data.table)
# read-in test, training, activities, and subject data sets
testData <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
testData_act <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)
testData_sub <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
trainData <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
trainData_act <- read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
trainData_sub <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)

# Assign descriptive activity names to activities inside the test and train data sets
activities <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE,colClasses="character")
testData_act$V1 <- factor(testData_act$V1,levels=activities$V1,labels=activities$V2)
trainData_act$V1 <- factor(trainData_act$V1,levels=activities$V1,labels=activities$V2)

# Label the data sets' headers with descriptive variable names
# and select the variables of mean and standard deviation ones
features <- read.table("./UCI HAR Dataset/features.txt",header=FALSE,colClasses="character")
colsWeWant <- grep(".*mean.*|.*Mean.*|.*std.*|.*Std*", features[,2])
colnames(testData)<-features$V2
colnames(trainData)<-features$V2
colnames(testData_act)<-c("Activity")
colnames(trainData_act)<-c("Activity")
colnames(testData_sub)<-c("Subject")
colnames(trainData_sub)<-c("Subject")

# Extracts only the measurements on the mean and standard deviation 
# for each measurement. Merge test and training sets into a joint data 
# set along with their corresponding activities and subjects
testData<-testData[,colsWeWant]
trainData<-trainData[,colsWeWant]
testData<-cbind(testData,testData_act)
testData<-cbind(testData,testData_sub)
trainData<-cbind(trainData,trainData_act)
trainData<-cbind(trainData,trainData_sub)
jointData<-rbind(testData,trainData)

# From the joint data set, to create a second, independent tidy data set 
# with the average of each variable for each activity and each subject. Write to file "tidyData.txt"
dt<- data.table(jointData)
tidyData<-dt[,lapply(.SD,mean),by="Activity,Subject"]
write.table(tidyData,file="tidyData.txt",row.name=FALSE)
