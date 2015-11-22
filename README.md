#Purpose
The purpose of this code is to take information from website https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
and look at the mean for every subject (there are 30 test subjects) for each of the 6 activities. 

While it was possible to look by subject and activity, that was not the goal as it would have created 180 different means for each of the different variables. The information was however calculated and made into a list called ti83 and a dataframe called ti84 for those who are interested in it.

###Notes on running on windows
This  code was written to work with the directory system of Linux. On Windows the slashes need to be in the opposite direction.
Also there are two slashes in windows for every slash in Linux. 

The codes starts by checking to make sure that the information is not overwriting anything and then make a new directory. The program systematically looks for an unused directory name. The possibilities included are data, data2 and, dat3 . 

Once a directory has been established the data downloads into the directory. Alternatively, if the data, a file called test.zip was already there, the code to download can be omitted. The test.zip file can be found on the github repository.


The file features.txt is read to extract variable names. It is then processed to make sure the names are unique.

It is preferred that the variable names be lower case and without commas and dashes so the code converts them.


The test data and the training data are then merged into one dataframe. They start off in 6 seperate files. This involves reading the files  X_train.txt,  Y_train.txt,  S_train.txt,  X_test.txt, Y_test.txt, and S_test.txt into R and using cbind on the test data to make that into a single data frame, cbind on the training data to make that into a single data frame, and then rbind to merge them together.

The columns that relate to the mean and standard deviation are then extracted with perl regular expressions and the grepl function.

The result is then averaged across the activity types and the subjects.

#A table containing all the data is named bigtable.txt,

# a table with just the means of the means and standard deviations, grouped by person and activity is called tidyDataSet.txt .
