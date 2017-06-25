library(plyr)
library(dplyr)

ACTIVITIES = c('walking', 'upstairs', 'downstairs', 'sitting', 'standing',
               'laying')

get_mean_std_cols = function() {
    features = read.table('UCI HAR Dataset/features.txt')
    sel = grep('-mean\\(\\)$|-std\\(\\)$', features$V2)
    features[sel, ]
}

# 1. Merges the training and the test sets to create one data set.
merge = function() {
    # Read data files
    df_train_features = read.table('UCI HAR Dataset/train/X_train.txt')
    df_train_activity = read.table('UCI HAR Dataset/train/y_train.txt')
    df_train_subject  = read.table('UCI HAR Dataset/train/subject_train.txt')
    df_test_features  = read.table('UCI HAR Dataset/test/X_test.txt')
    df_test_activity  = read.table('UCI HAR Dataset/test/y_test.txt')
    df_test_subject   = read.table('UCI HAR Dataset/test/subject_test.txt')
    # Unify data frames
    names(df_train_activity) = 'activity'
    names(df_train_subject)  = 'subject'
    names(df_test_activity)  = 'activity'
    names(df_test_subject)   = 'subject'
    df_train = cbind(df_train_features, df_train_subject, df_train_activity)
    df_test  = cbind( df_test_features, df_test_subject,  df_test_activity)
    # Append data frames
    rbind(df_train, df_test)
}

# 2. Extracts only the measurements on the mean and standard deviation for each
# measurement.
extract = function(df) {
    mean_std_cols = get_mean_std_cols()[, 1]
    cbind(df[, mean_std_cols], df[c('subject', 'activity')])
}

# 3. Uses descriptive activity names to name the activities in the data set
adjust_activities = function(df) {
    df$activity = factor(df$activity, labels = ACTIVITIES)
    return(df)
}

# 4. Appropriately labels the data set with descriptive variable names.
label = function(df) {
    cnames = as.character(get_mean_std_cols()[, 2])
    cnames = sub('-mean\\(\\)$', 'Mean', cnames)
    cnames = sub('-std\\(\\)$', 'Std', cnames)
    names(df)[seq_along(cnames)] = cnames
    return(df)
}

# 5. From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject.
summ = function(df) {
    as_tibble(df) %>% group_by(subject, activity) %>% summarise(
        tBodyAccMagMean = mean(tBodyAccMagMean),
        tBodyAccMagStd = mean(tBodyAccMagStd),
        tGravityAccMagMean = mean(tGravityAccMagMean),
        tGravityAccMagStd = mean(tGravityAccMagStd),
        tBodyAccJerkMagMean = mean(tBodyAccJerkMagMean),
        tBodyAccJerkMagStd = mean(tBodyAccJerkMagStd),
        tBodyGyroMagMean = mean(tBodyGyroMagMean),
        tBodyGyroMagStd = mean(tBodyGyroMagStd),
        tBodyGyroJerkMagMean = mean(tBodyGyroJerkMagMean),
        tBodyGyroJerkMagStd = mean(tBodyGyroJerkMagStd),
        fBodyAccMagMean = mean(fBodyAccMagMean),
        fBodyAccMagStd = mean(fBodyAccMagStd),
        fBodyBodyAccJerkMagMean = mean(fBodyBodyAccJerkMagMean),
        fBodyBodyAccJerkMagStd = mean(fBodyBodyAccJerkMagStd),
        fBodyBodyGyroMagMean = mean(fBodyBodyGyroMagMean),
        fBodyBodyGyroMagStd = mean(fBodyBodyGyroMagStd),
        fBodyBodyGyroJerkMagMean = mean(fBodyBodyGyroJerkMagMean),
        fBodyBodyGyroJerkMagStd = mean(fBodyBodyGyroJerkMagStd)
    )
}
