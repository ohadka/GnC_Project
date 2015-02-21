## Getting and Cleaning data Project

In this file I'll explain the logic of the scripts. The script itself is accompanied by detailed explanations.

the run_analysis.R file includes 2 major parts:
* Setup, Download and Unzip
* run_analysis.R function

Let's look into each section:


### Setup, Download and Unzip

This section deals with the initial setup, getting and reading the data

1. Setting the work directory by using setwd
2. Loading required R packages: plyr and dplyr
3. Downloading the zip file by using download.file
4. unzipping the file by using unzip
5. Transferring the data from the unzipped files into data frames by using read.table

### run_analysis function

1. function receives 8 data frames (that were prepared in the previous section)
2. Renames the 2 columns of Activity labels data frame by using colnames
3. Binding the test data with the activity labels and volunteers list + renaming first 2 columns (volunteer & Label)
4. Binding the training data with the activity labels and volunteers list + renaming first 2 columns (volunteer & Label)

1st task: 
5. Merging the test and training datasets by using bind.rows

2nd task:
6. Extracting only the measurements on the mean and standard deviation for each measurement by searching for al variable names that include the word "mean" or "std" (both searches results saved in 2 vectors)
7. combining the 2 vectors into an aggregated unique and sorted vector
8. Creating a new data frame (including the 2 first columns (Volunteer & Label) 
9. Looping throw all relevant column indexes and adding those columns to the new dataset called ans2 (by using cbind)

3rd task:
10.Rename Activities with descriptive activities names by using merge between existing dataset(ans2) and the activities labels dataset (and making sure this function won't mess the columns order)

4th task:
11.Appropriately label the data set with descriptive variable names by looping through the relevant columns and changing the column name (by using colnames) to the names as appears in the features dataset (as String)

5th task:
12. Creating a second tidy data set with the average of each variable for each activity and each subject by grouping the existing dataset by Activity name and Volunteer(subject)
13. using dplyr summaries_each  function to produce the mean summary of all variables per Activity and test subject
14. exporting the resulting data set into a txt file

* For more detailed explanations please refer to the run_analysis.R file