Code Book

This book references the file "avg-data.R", an output of the script "run_analysis.R"
See the README.md in the repo for information how these were derived
See features_info.txt and README.txt in the UCI HAR Dataset for information on
how the original data was derived and sorted

###ID Variables
#subject
	-Factor variable with 30 levels, 1:30
	-Unique identifaction for each subject

#activity
-Unordered factor variable with 6 levels
	1. WALKING
	2. WALKING_UPSTAIRS
	3. WALKING_DOWNSTAIRS
	4. SITTING
	5. STANDING
	6. LAYING_DOWN
	
###Variables

Each of these are the mean of the mean and standard deviation of the
signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

meanoftBodyAcc-XYZ
meanoftGravityAcc-XYZ
meanoftBodyAccJerk-XYZ
meanoftBodyGyro-XYZ
meanoftBodyGyroJerk-XYZ
meanoftBodyAccMag
meanoftGravityAccMag
meanoftBodyAccJerkMag
meanoftBodyGyroMag
meanoftBodyGyroJerkMag
meanoffBodyAcc-XYZ
meanoffBodyAccJerk-XYZ
meanoffBodyGyro-XYZ
meanoffBodyAccMag
meanoffBodyAccJerkM