run.analysis README file
--Getting and Cleaning Data course assignment
========================================================

1. Read in the data in the train.txt file, the subject in the subjectTrain.txt file,
the activity in the activityTrain file, and combine then together to form a data fram "train".
Read in the data in the test.txt file, the subject in the subjectTest.txt file,
the activity in the activityTest file, and combine then together to form a data fram "test".
And then join the "train and "test" files to form a dataframe "df".

```{r}
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
df<-rbind(train,test)
```

2. Read in the variable names from the features.txt file, and replace the variable names.

```{r}
varName<-read.table("features.txt")
varName<-make.names(varName[,2])
colnames(df)[3:563]<-varName
colnames(df)[1:2]<-c("subject", "activity")
```
3. Remove the columns not containing the mean and std data.
```{r}
meanStd<-grep("mean|std", varName1, value=T)
df<-cbind(df[,c(1,2)], df[,meanStd])
```
4. Change the dummy code of the activity column into the meaningful names.
```{r}
df[df[,2]==1, 2]="WALKING2"
df[df[,2]==2, 2]="WALKING_UPSTAIRS"
df[df[,2]==3, 2]="WALKING_DOWNSTAIRS"
df[df[,2]==4, 2]="SITTING"
df[df[,2]==5, 2]="STANDING"
df[df[,2]==6, 2]="LAYING"
df<-df[order(as.numeric(df[,1])),]
```
5. Aggregate the data based on the object and the activity columns, and adjust the columns.
```{r}
aggdf<-aggregate(df, by=list(df[,2], df[,1]), FUN=mean)
aggdf<-cbind(aggdf[,2], aggdf[, -(2:4)])
colnames(aggdf)[1:2]<-c("subject", "activity")
```
6. Write the aggregated tidy table into the "dy_dity.txt" file.
```{r}
write.table(aggdf, file="df_tidy.txt", row.names=FALSE)
```

