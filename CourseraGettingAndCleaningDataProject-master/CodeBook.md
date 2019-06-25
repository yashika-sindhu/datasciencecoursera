This analysis is done to clean a dataset for the final Projet of a course Getting and Cleaning data Coursera

Details about the data set are given in the README.md file.
======================================

In this file we will understand how the script is written for getting a tidy dataset from the given source.

- download the .zip data using download.file
- unzip the data using function unzip()
- read all the required data from the folder to different variables using data.table function so that we can work with the data frames
- the variables from reading this data includes:

activity_labels > inclues activity number to name mapping
features > includes the names of 561 different values derived from the readings
train_labels > includes activity labels mapping to the calculated values of training readings
test_labels > includes activity labels mapping to the calculated values of testing readings
subject_train > includes subjects mapping to the training readings
subject_test > includes subjects mapping to the testing readings
train_x > includes the calculated values on training readings according to features
test_x > includes the calculated values on testing readings according to features

Now for our fist tidy data set we need to get all mean() and std() calculated values from the train_x and test_x corresponding to the subjects and activities
- we get a data frame for the index and names of all values which contains a mean() or std()
- merge the test and train activity labels mapping their activity names corresponding to dataset
- columns bind with the subjects number mapping
- add the mean() and std() values from the test_x and train_x dataframes
- row bind the test and train dataset to create a complete dataset
- add names to this final data set

Now for our second dataset we need to calculate mean of all values per subject per activity
- use aggregate() to calculate mean on the dataset grouped by Subject Number and Activity Name
- Delete the columns added due to aggrerate()
