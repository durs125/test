
#Purpose
The purpose of this code is to take information from website https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
and look at the mean for every subject (there are 30 test subjects) for each of the 6 activities. 

###Notes on running on windows
This  code was written to work with the directory system of Linux. On Windows the slashes need to be in the opposite direction.
Also there are two slashes in windows for every slash in Linux. 

The codes starts by checking to make sure that the information is not overwriting anything and then make a new directory. The program systematicly looks for an unused directory name. The possibilities included are data, data2 and, dat3  . I know this was not part of the assignment but I felt like it.

Once a directory has been established the data downloads into the directory. Alternatively, if the data was already there the code to download can be omitted.

It is preferred that the variable names be lower case and without commas, and dashes so the code converts them.

The file features.txt is read to extract variable names. It is then processed to make sure the names are unique.

The test data and the training data are then merged into one dataframe. This involves reading the files  X_train.txt,  Y_train.txt,  S_train.txt,  X_test.txt, Y_test.txt, and S_test.txt.

The columns that relate to the mean and standard deviation are then extracted with perl regular expressions and the grepl function.

#A table containing all the data is named bigtable.txt,

# a table with just the means of the means and standard deviations is called smalltable.txt .


