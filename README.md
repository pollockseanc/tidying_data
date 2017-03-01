==================================================================
Analysis of the Human Activity Recognition Using Smartphones Dataset
==================================================================
An analysis was run on the datasetHuman Activity Recognition Using Smartphones Data Set provided by UCI

Information can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data can be downloaded it:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

What is the purpose of this script :
==================================================================

This script outputs the file 'avg_data.txt' that is contains the average of the means and standard deviation of 
the measurements in the dataset. It is sorted by the subject ID and activity. 

The repo contains the following and R packagesfiles:
==================================================================
#Files
- 'README.txt'
- 'run_analysis.R': Script that executes the analysis and data transformation

- 'analysis_functions.R': Script that contains the necessary functions and descriptions of functions

- 'CodeBook.md': Codebook describing the variables in the final output

- 'avg_data.txt': Not required, output of the analysis

- 'ucidata.RMD': Not required, RMD file used to test and create analysis

- 'ucitesting.RMD': Not required, RMD file used to test and create analysis

#R Packages
- dplyr
- dtplyr
- data.table


This analysis requires the following files from the dataset:
==================================================================

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Table of the activities and their ID

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity

To use this script:
==================================================================

Step 1:
Download data from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 
Step 2: 
Download this repo

Step 3: 
Put 'run_analysis.R' and 'analysis_functions.R' into your working directory

Step 4:
Unzip the data into your working directory

Step 5:
Open and run 'run_analysis.R'. This can be done by command line or in R Studio
Note: This script requires the file 'analysis_functions.R' for called functions

Step 6: 
You can now view the 'avg_data.txt' file that contains the output. It is recommended you read
this into R with

fread("avg_data.txt", header=T)

What does this script do:
==================================================================

Initially it reads the files from the data set into R and creates data.tables 

Variable names are then set using manual means and by reading the variable names from the features file with the function add_feature_names. 
This is done early to increase ease of coding and for use with the data.table package

Next two data.tables are created using the merge_columns function.
This is run twice, once for the training data and once for testing data.
It is passed the subject, test and label data for each.
This function calls the create_key function to create ID and key for the passed tables
The key is created by counting the number of rows, and assigning then assignigning the ID to that value
ending with double the number of rows minus 1. This was chosen to allow the data to later be sorted by 
testing and training data if the ID. The number of rows in training and test data do not overlap this way.

Next the merge_rows function combines the two data.tables containing the test and training data
This is done by matching the name of the columns

Next the function extract_mean_std is called to extract the columns that contain the subject id, activity
and the columns containing data that involves the mean and standard deviation. This is designed in a way to avoid
pulling in the columns that contain data on the meanFreq() the angular Calculation, as these are not measures of the activity.

Next the tyding of the data begins.

Next the replace_activities function takes the extracted data and replaces the activity level id with the label from the 'activity_labels.txt'
file. To do this the activity column in the extracted data is converted to the character type from numeric.

The next step is to tidy up the variable names and column datatypes. 
This is done by calling the tidy_data_function
First the subject and activity columns are converted to unordered factors.
The make_lower_case function is called from the passed data_table, this makes all the variable names lowercase
The non alphabetical characters in the variable names are then removed.

The tidied and extracted day is now sorted and averaged.
Using the average_data function  the columns containing the subject and activity are melted to be IDs.
Then it is sorted by the subject id and then the activity, and then the mean of the other variable columns.

The last step in transforming the data is to add an identifier to the variables that were averaged.
The label_avg function does this by pasting "meanof" to the numeric variables titles. 

Finally the data is written to a table in the text file "avg_data.txt"



 


