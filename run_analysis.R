library(plyr)

#Collect all the important data
xTrain<-read.table("train/X_train.txt")
xTest<-read.table("test/X_test.txt")
yTrain<-read.table("train/y_train.txt")
yTest<-read.table("test/y_test.txt")
subjectTrain<-read.table("train/subject_train.txt")
subjectTest<-read.table("test/subject_test.txt")

#Merge X, Y, and subject
X<-rbind(xTrain,xTest)
Y<-rbind(yTrain,yTest)
subject<-rbind(subjectTrain,subjectTest)

#Extract only measurements on the mean and sd
features<-read.table("features.txt")
columns<-grep("-(mean|std)\\(\\)",features[,2])
X<-X[,columns]
names(X)<-features[columns,2]

#Use descriptive activity names in the data set
activities <- read.table("activity_labels.txt")
Y[,1]<-activities[Y[,1],2]
names(Y)<-"activity"

#Label appropiately the data set
names(subject)<-"subject"

#Create the final data set
collected<-cbind(X,Y,subject)
finale<-ddply(collected,.(subject, activity),function(x) colMeans(x[, 1:66]))
write.table(finale, "finalDataSet.txt", row.name=FALSE)
