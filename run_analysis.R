# Turn on the necessary packages
library("tables")

library("srtingr")
library("reshape2")

##This  code was written to work with the directory system of Linux. On Windows the slashes need to be in the oposite direction
##Also there are two slashes in windows for every slash in Linux. 

# First check to make sure that the infomation is not overwritting anything and then make a new directory.

if(!file.exists("data")){
        dir.create("data")
        setwd("data")
}else if (!file.exists("data2")){
        setwd("data2")
           dir.create("data2")
        }else if (!file.exists("dat3")){
                dir.create("dat3")
                setwd("dat3")
                }
                # download the file and unzip it
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","test.zip")
datedownloaded<-date()
unzip("test.zip")
setwd("UCI HAR Dataset")
#As an alternative the data can be taken off the github repo 

#Read the variable names and make what will become the variable names lower case
xx<-read.table("features.txt")
xx<-lapply(xx,tolower)
##The following takes the names and removes commas and dashes
xxx2<-gsub("[/(]|[)]|/,|/-","",xx[[2]],perl=TRUE)
xxx3<-gsub(",|[/-]","",xxx2,perl=TRUE)


#It does not work too well on things that would be split into more than 3 parts but that is fine for this data set 
#All of the names in this data set that we care about are only 2 or 3 long


#Not the most efficient way to do things but this takes care of the duplicate names issue
xxx4<-as.data.frame(table(as.list(1:561),dnn=xxx3))

xxx4<-xxx4[,]
vv<-as.character(names(xxx4))[1:561]
X_test<-read.table("test/X_test.txt",col.names=vv)

Y_test<-read.table("test/y_test.txt",col.names="activity")

S_test<-read.table("test/subject_test.txt", col.names = "testsubject")

testds<-cbind(S_test,Y_test,X_test)

#Combind all of the training data into one data frame
X_train<-read.table("train/X_train.txt",col.names=vv)
Y_train<-read.table("train/y_train.txt",col.names="activity")
S_train<-read.table("train/subject_train.txt", col.names = "testsubject")
trainds<-cbind(S_train,Y_train,X_train)

theds<-rbind2(testds,trainds)
# thsi writes the combind raw data into a table called "bigtable.csv"

#I need to take the headers and compare it using pearl style regular experessions to mean and std
theds2<-theds[,sapply(names(theds),grepl,pattern="mean|std|test.*ubject|activity",perl=TRUE)]
theds[,2]<-factor(theds2[,2], levels=1:6, labels=c('WALKING', 'WALKINGUPSTAIRS',  'WALKING_DOWNSTAIRS','SITTING','STANDING', 'LAYING'))
write.table(theds2,"bigtable.txt",row.name=TRUE)
ti<-data.frame(names(theds[,3:88]),row.names = names(theds[,3:88]))
ti81<-list(personoractivity=c(as.character(1:30)))
ti82<-list(personoractivity=c('WALKING', 'WALKINGUPSTAIRS',  'WALKING_DOWNSTAIRS','SITTING','STANDING', 'LAYING'))
ti83<-as.list(t(ti))
#vector of subject and activity to divid the data by
subac<-apply(matrix(c(theds2[,2],theds2[,1]),ncol=2),1,function(x)paste("subject",x[1], "activity",x[2], sep=""))


for (i in 3:88){ti81[[names(theds2[,i,drop=FALSE])]]<- tapply(theds2[,i],theds2[,1],FUN=mean)}
for (i in 3:88){ti82[[names(theds2[,i,drop=FALSE])]]<- tapply(theds2[,i],theds2[,2],FUN=mean)}
for (i in 3:88){ti83[[names(theds2[,i,drop=FALSE])]]<- tapply(theds2[,i],subac,FUN=mean)}



ti84<-as.data.frame(ti83)


names(ti83)<-tolower(names(ti83))
names(ti83)<-gsub("[x/.]","",names(ti83),perl=TRUE)
#
names(ti84)<-tolower(names(ti84))
names(ti84)<-gsub("[x/.]","",names(ti84),perl=TRUE)


ti82a<-as.data.frame(ti82)
names(ti82a)<-tolower(names(ti82a))
names(ti82a)<-gsub("[x/.]","",names(ti82a),perl=TRUE)

ti81a<-as.data.frame(ti81)
names(ti81a)<-tolower(names(ti81a))
names(ti81a)<-gsub("[x/.]","",names(ti81a),perl=TRUE)


titl<-rbind(ti82a,ti81a)
write.table(titl,"tidyDataSet.txt",row.name=FALSE )
