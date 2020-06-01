#The submitted data set is tidy.
#The Github repo contains the required scripts.
#GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
#The README that explains the analysis files is clear and understandable.
#The work submitted for this project is the work of the student who submitted it.

#First of all, looking through all files layout 
#We need to label acitivities in train/test data set
#and also name columns of both sets using features

#1. read acitivy_labels.txt for matching with train/test

activity<-read.csv("activity_labels.txt",header=FALSE,sep=" ")
names(activity)<-c("activity_id","activity_nm")


#2. read features.txt for naming columns for train/test

features<-read.csv("features.txt",header=FALSE," ") 
head(features)

#3. read train data sets

    #according to readme file, Each row identifies the subject who performed the activity
    
    subject_train<-read.csv("train/subject_train.txt",header=FALSE)
    
    train_data<-read.table("train/X_train.txt",header=FALSE,sep="")
    
    train_label_data<-read.table("train/Y_train.txt", header=FALSE,sep="")
    
    #before cbinding all 3 data, we need to names each data set for merging
    #And add extra column subject_type to distinguish from test data.
    
    names(subject_train)<-"subject_id"
    subject_train$subject_type = "TRAIN"
    names(train_data)<-features[,2]
    names(train_label_data)<-"activity_id"
    
    train_set <- cbind(subject_train,train_data,train_label_data)
    
    #matching with activity labels
    
    train_set <-merge(train_set, activity, by.x="activity_id", by.y="activity_id")
    
    train_set$activity_nm<-as.factor(train_set$activity_nm)
    
    #activity_id removal
    train_set$activity_id = NULL
    
#Repeat same operation for test data files except for file_names, subject_type (this time , it should be test)
    
#4. read test data sets
    
    #according to readme file, Each row identifies the subject who performed the activity
    
    subject_test<-read.csv("test/subject_test.txt",header=FALSE)
    
    test_data<-read.table("test/X_test.txt",header=FALSE,sep="")
    
    test_label_data<-read.table("test/Y_test.txt", header=FALSE,sep="")
    
    #before cbinding all 3 data, we need to names each data set for merging
    #And add extra column subject_type to distinguish from train data.
    
    names(subject_test)<-"subject_id"
    subject_test$subject_type = "TEST"
    names(test_data)<-features[,2] 
    
    names(test_label_data)<-"activity_id"
    
    test_set <- cbind(subject_test,test_data,test_label_data)
     
    #matching with activity labels
    
    test_set <-merge(test_set, activity, by.x="activity_id", by.y="activity_id")
     
    test_set$activity_nm<-as.factor(test_set$activity_nm)
    
    #activity_id removal
    test_set$activity_id = NULL


#5, rbind two sets, train_set and test_set
    
    tot_set <- rbind(train_set,test_set) 
    tot_set$subject_type<-as.factor(tot_set$subject_type)

#Extracting only the measurements on the mean and standard deviation for each measurement    
    
# using regular expression, finding column names containing mean(, std(

    index_vect <-c(grep("mean[(]+",names(tot_set)),grep("std[(]+",names(tot_set)))

    ext_set <- tot_set[, c("activity_nm","subject_id",names(tot_set)[index_vect])] 
    
    
# creates a second, independent tidy data set with the average of each variable for each activity and each subject.    

    ext_set<-ext_set[order(ext_set$subject_id, ext_set$activity_nm),] 
    groupColumns <-names(ext_set)[2:1]
    dataColumns <-names(ext_set)[-(1:2)]
    
    library(plyr)
    result <- ddply(ext_set, groupColumns, function(x) colSums(x[dataColumns]))
    names(result)<-make.names(names(result))
# Finally writing tidy dataset!
    write.table(result,"tidyData.txt",row.names=FALSE)
    
    
    