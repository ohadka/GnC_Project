## Getting and Cleaning data Project - Code book

### Human Activity Recognition Using Smartphones Dataset

### Data - General Overview
The raw data is based on an experiment tracking 30 volunteers activities and measurements coming from an accelerometer and  
gyroscope installed in a Samsung Galaxy S II smartphone carried by the experiment subjects.
Data is split into test(30%) and training(70%) sections of the experiment and includes 3 sets of files for each: 
1. Identifier of the subject who carried out the experiment 
2. Activity label (1 per sample)
3. Experiment measurements (561 variables) including time and frequency domain variables

In addition the data includes a file that contains the reference table for activity labels (translated to descriptive  
activity name)

For more information concerning the experiment please refer to this [location](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

### Data - Variables Overview
Variables include:
1. Experiment subject identifier (a.k.a Volunteer) 1-30
2. Analyzed Activity (a.k.a Label) 1-6
3. 561 variables of measurement coming from the smartphone sensors (full list can be found in the following link


### Data Acquisition
Data is saved as a Zipped set of text files on the following [location](https://d396qusza40orc.cloudfront.net/getdata 
%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The R script downloads the zipped file to my working directory, unzips it and reads the files into workable data frames
(see more details in the README.md file)


### Data Transformation

in order to get the end result - a tidy dataset I followed the following steps:
1. Merge both training and test data with the list of observed activity identifiers and experiment subjects
2. Merge both training and test data frames into 1 working data frame
3. Extract only the columns on the mean and standard deviation measurements
4. Add the descriptive activity name to the data frame (in addition to the existing activity label)
5. Label the measurements columns with descriptive feature labels
6. Create a second tidy data set with the average of each variable for each activity and each subject - End result!
(see more details in the README.md file)
