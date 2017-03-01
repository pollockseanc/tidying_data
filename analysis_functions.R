#These functions are used in the file "run_analysis.R"
#Libraries required:
#dplyr
#dtplyr
#data.table

#Functions are ordered by when they are called in run_analysis.R
#or before functions that depend on them
#e.g. merge_columns calls create_key, so it is listed above it



#Adds the feature names from the file "features.txt" to the experiment data

add_feature_names <- function(data_table, features) {
        feature_names <- features[[2]]
        data_table <- setnames(data_table, feature_names)
        return(data_table)
}

#In order to merge the data.tables each table needs a key
#Since the tables had nothing to connect them, a column is created
#that IDs the data that column is then set to the key of the table
#Returns a data.table
create_key <- function(data_table) {
        
        start <- nrow(data_table) +1
        end <- nrow(data_table) * 2
        data_table <- mutate(data_table, id = (start:end))
        setkey(data_table, id)
        return(data_table)
        
}

#Merges the three data tables from each group of data

merge_columns <- function (subject, set,labels){
        #requires data.table library
        subject <- create_key(subject)
        set <- create_key(set)
        labels <- create_key(labels)
        merged_columns <- subject[labels[set]]
        return(merged_columns)
}

#This merges the two data.tables created from the merge_columns function
#It merges by row using the names of the tables, the tables must have the variable names

merge_rows <- function (merged_training_data, merged_testing_data) {
        merged_data <- rbindlist(list(merged_training_data, merged_testing_data), use.names = T)
        return(merged_data)
}

#extracts the columns that find the mean and standard deviation of a variable
#does not include meanFreq() as this is a measure of something effecting the variable, not the variable itself
#does not include angle variables either

extract_mean_std <- function(data_table) {
      
        mean_std_loc <- grep("mean\\(|std", names(merged_data))
        extracted_data <- select(data_table, data_table[,c(1,3,mean_std_loc)])
        return(extracted_data)
}

#Replaces the numerical data that was used to categorize the activities
#Uses the labels from the activity_labels.txt file

replace_activities <- function(data_table, activity_labels) {
        
        activity_levels <- range(activity_labels$factor)
        data_table$activity <- as.character(data_table$activity)
        for (i in 1:max(activity_levels)) {
                data_table[data_table$activity == as.character(i), "activity"] <- activity_labels[i,"activity"]
                
        }
        return(data_table)
}

#Makes all the variable names lowercase
make_lower_case <- function (data_table) {
        col_names_lower <- tolower(names(data_table))
        data_table <- setnames(data_table, col_names_lower)
        return(data_table)
        
        
}

#Tidies up the data and variables
tidy_data <- function (data_table) {
        
        #Sets the the subject id and activity column classes to factor
        data_table$subject <- as.factor(data_table$subject)
        data_table$activity <- as.factor(data_table$activity)
        #Makes the variables lowercase
        data_table <- make_lower_case(data_table)
        #Removes non alphabetical characters in the variable names
        names1 <- gsub("-|\\(\\)","", names(data_table))
        data_table <- setnames(data_table, names1)
        return(data_table)
}

#Takes the data and averages the variables for each activity and subject
#Sorts the data first by subject then by activity 

average_data <- function (data_table) {
        #Separates the columns into ID columns and Variable columns
        data_table <- melt(data_table, id=c("subject", "activity"))
        #Averages the variable columns and sorts the data
        data_table <- dcast(data_table, subject + activity ~ variable, mean)
        
        return(data_table)
        
        
}

#Adds meanof to the front of the variable names that were averaged
label_avg <- function (data_table) {
        
        dnames <- names(data_table)
        dnames[3:68] <- paste0("meanof", dnames[3:68])
        data_table <- setnames(data_table[], dnames)
        return(data_table)
        
}
