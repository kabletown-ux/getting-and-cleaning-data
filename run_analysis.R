debug <- TRUE

## cache ttest/train data: 50x speedup
xTrain <- NULL
xTest  <- NULL
yTrain <- NULL
yTest  <- NULL

runAnalysis <- function() {

    ptm <- proc.time()
    
    library( plyr )
    readData <- function( path ) {
        
        if ( debug ) print( file.path( "UCI HAR Dataset", path, fsep = .Platform$file.sep ) )
        read.table( file.path( "UCI HAR Dataset", path, fsep = .Platform$file.sep ) )
    }
    
    ## Read training and testing data when not already present in global vars (xTrain, xTest)
    ## Use of <<
    if ( debug ) print( "Preparing to ready xTrain and xTest... " )
    if ( is.null( xTrain ) ) { xTrain <<- readData( "train/X_train.txt" ) }
    if ( is.null( xTest ) )  { xTest  <<- readData( "test/X_test.txt" ) }
    if ( debug ) print( "Preparing to ready xTrain and xTest... Done" )
    
    ## Instruction 1) Merge the training and the test sets to create one data set.
    xTrainAndTest <- rbind( xTrain, xTest )
    
    ## read 2nd column of names, skip line numbers (col 1)
    featureNames <- readData( "features.txt" )[ , 2 ]
    names( xTrainAndTest ) <- featureNames
    
    ## Instruction 2) Extract only the measurements on the mean and standard deviation for each measurement.
    ## Limit to columns with feature names matching mean() or std():
    matchedMeanOrStdDev <- grep( "(mean|std)\\(\\)", names( xTrainAndTest ) )
    meanOrStdDev <- xTrainAndTest[ , matchedMeanOrStdDev ]
    
    ## Instruction 3) Use descriptive activity names to name the activities in the data set.
    if ( debug ) print( "Preparing to ready yTrain and yTest..." )
    if ( is.null( yTrain ) ) { yTrain <<- readData( "train/y_train.txt" ) }
    if ( is.null( yTest ) ) { yTest  <<- readData( "test/y_test.txt" ) }
    yTrainAndTest <- rbind( yTrain, yTest )[ , 1 ]
    if ( debug ) print( "Preparing to ready yTrain and yTest... Done" )
    
    ## Get the activity data and map to more descriptive names:
    activityNames <- c( "WALKING", "WALKING UPSTAIRS", "WALKING DOWNSTAIRS", "SITTING", "STANDING", "LAYING" )
    activities <- activityNames[ yTrainAndTest ]
    
    ## Instruction 4) Appropriately label the data set with descriptive variable names.
    ## Using gsum: substitute Time for t, Frequency for f, Mean for mean() and StdDev for std()
    ## Remove extra dashes and BodyBody naming error from original feature names
    names ( meanOrStdDev ) <- gsub( "^t", "Time", names ( meanOrStdDev ) )
    names ( meanOrStdDev ) <- gsub( "^f", "Frequency", names ( meanOrStdDev ) )
    names ( meanOrStdDev ) <- gsub( "-mean\\(\\)", "Mean", names ( meanOrStdDev ) )
    names ( meanOrStdDev ) <- gsub( "-std\\(\\)", "StdDev", names ( meanOrStdDev ) )
    names ( meanOrStdDev ) <- gsub( "-", "", names ( meanOrStdDev ) )
    names ( meanOrStdDev ) <- gsub( "BodyBody", "Body", names ( meanOrStdDev ) )
    
    # Add activities and subject with nice names
    subjectTrain <- readData( "train/subject_train.txt" )
    subjectTest  <- readData( "test/subject_test.txt" )
    subjects <- rbind( subjectTrain, subjectTest )[ , 1 ]
    #print( subjects )
    
    tidy <- cbind( Subject = subjects, Activity = activities, meanOrStdDev )
    
    ## Instruction 5) Create a second, independent tidy data set with the average of each variable for each activity and each subject.
    # Column means for all but the subject and activity columns
    limitedColMeans <- function( data ) { colMeans( data[,-c( 1, 2 ) ] ) } ## -c( 1, 2 ) = except cols 1 & 2
    tidyMeans <- ddply( tidy, .( Subject, Activity ), limitedColMeans )
    names( tidyMeans )[ -c( 1, 2 ) ] <- paste0( "Mean", names( tidyMeans )[ -c( 1, 2 ) ] )
    
    # Write file
    write.table(tidyMeans, "tidyMeans.txt", row.names = FALSE)
    
    # return tidy'd data
    tidyMeans
    
    # Stop the clock: caching data x|yTrain, x|yTest saves time, but only when global env isn't reset...
    #proc.time() - ptm    
}


