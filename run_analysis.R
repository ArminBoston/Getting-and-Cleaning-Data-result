##Read in the training and test data and their corresponding subject
##and activity data. And then combine them together.
train<-read.table("train\\X_train.txt", sep="")
test<-read.table("test\\X_test.txt", sep="")
subjectTrain<-read.table("train\\subject_train.txt")
activityTrain<-read.table("train\\y_train.txt")
train<-cbind(activityTrain, train)
train<-cbind(subjectTrain, train)
subjectTest<-read.table("test\\subject_test.txt")
activityTest<-read.table("test\\y_test.txt")
test<-cbind(activityTest, test)
test<-cbind(subjectTest, test)

##Join the train and test data into a single dataframe "df". 
df<-rbind(train,test)

##Replace the column names.
varName<-read.table("features.txt")
varName<-make.names(varName[,2])
colnames(df)[3:563]<-varName
colnames(df)[1:2]<-c("subject", "activity")

##Keep the cloumns containing mean and standard values.
meanStd<-grep("mean|std", varName1, value=T)
df<-cbind(df[,c(1,2)], df[,meanStd])

##change the activity dummy into meaningful name, and 
##order the subjects.
df[df[,2]==1, 2]="WALKING2"
df[df[,2]==2, 2]="WALKING_UPSTAIRS"
df[df[,2]==3, 2]="WALKING_DOWNSTAIRS"
df[df[,2]==4, 2]="SITTING"
df[df[,2]==5, 2]="STANDING"
df[df[,2]==6, 2]="LAYING"
df<-df[order(as.numeric(df[,1])),]

##Aggregate the subjects and activities.
aggdf<-aggregate(df, by=list(df[,2], df[,1]), FUN=mean)
aggdf<-cbind(aggdf[,2], aggdf[, -(2:4)]) #remove the two new columns the aggregate function creates and adjust the columns. 
colnames(aggdf)[1:2]<-c("subject", "activity") #replace the names of the first two columns.

##Write the tidy dataset in a file "df_tidy.txt".
write.table(aggdf, file="df_tidy.txt", row.names=FALSE)




































