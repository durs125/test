# Turn on the necessary packages
library("tables")

library("srtingr")
library("reshape2")

##THis  code was written to work with the directory system of Linux. On Windows the slashes need to be in the oposite direction
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


#xxx2<-strsplit(as.character(xx[[2]]),split="/,|/-",perl=TRUE)
#xxx2<-sapply(xxx2,function(x){strsplit(as.character(x[1]),split="-")})
##This nex bit takes the data that was split by the removal of the commas and dashes and pastes it back together.
#It does not work too well on things that would be split into more than 3 parts but that is fine for this data set 
#All of the names in this data set that we care about are only 2 or 3 long
#xxx3<-lapply(xxx2,function(x){paste(x[1],x[2],if(x[2]!=x[length(x)])x[length(x)])})




#Not the most efficient way to do things but this takes care of the duplicate names issue
#I suppoose I could have just appended a number to the end of each name
xxx4<-as.data.frame(table(as.list(1:561),dnn=xxx3))

xxx4<-xxx4[,]
#combind all the test data into one dataframe
#vv<-c(names(xxx4)[1:561])
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
write.table(theds2,"bigtable.txt",row.name=TRUE)
ti<-data.frame(names(theds[,3:88]),row.names = names(theds[,3:88]))
ti81<-as.list(t(ti))
ti82<-as.list(t(ti))
ti83<-as.list(t(ti))
#vector of subject and activity to divid the data by
subac<-apply(matrix(c(theds2[,2],theds2[,1]),ncol=2),1,function(x)paste("subject",x[1], "activity",x[2]))


for (i in 3:88){ti81[[names(theds2[,i,drop=FALSE])]]<- tapply(theds2[,i],theds2[,1],FUN=mean)}
for (i in 3:88){ti82[[names(theds2[,i,drop=FALSE])]]<- tapply(theds2[,i],theds2[,2],FUN=mean)}
for (i in 3:88){ti83[[names(theds2[,i,drop=FALSE])]]<- tapply(theds2[,i],subac,FUN=mean)}



write.table(as.data.frame(ti83),"smalltable.txt",row.name=FALSE )

# write.table() using row.name=FALSE 

