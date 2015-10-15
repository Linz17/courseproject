### Data

This is the [data (zip file)](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) provided for the assignment.
In includes data collected by Samsung Galaxy SII's accelerometer and gyroscope on 30 subjects performing 6 physical activities.
The resulting dataset contains averages of each mesurements by activity and by subject.

### Script

The script [run_analysis.R](.//run_analysis.R)) does the following:
- Downloads and extracts the data in the current working directory. The extracted directory is named "UCI HAR Dataset".
- Reads the texts files
- Combine data from the text files into one dataset (dataset)
- Extract only the mean and standard variation in another dataset (ds_meansd). Extraction is done based on column names.
- Averages data in final dataset (tidydata)

### Variables

1. Text files
  - **activity_labels**: Contains names of all 6 activities performed by subjects.
  - **features**: Contains names of all the mesurements.
  - **subject_test**: Contains ID of subject for each row, within the test group.
  - **subject_train**: Contains ID of subject for each row, within the train group.
  - **x_test**: Contains values of mesurements, within the test group.
  - **x_train**: Contains values of mesurements, within the train group.
  - **y_test**: Contains ID of activities, within the test group.
  - **y_train**: Contains ID of activities, within the train group.

2. Dataset
  - **dataset**: Global dataset containing subject ID, activity name, all mesurements.
  - **ds_meansd**: Filtered dataset containing subject ID, activity name, mesurements of means and standard deviations.
  - **tidydata**: Filtered dataset containing subject ID, activity name, and average of ds_meansd mesurements for each activity of each subject.

3. Mesurements
  - *Full description of all mesurements can be found in /UCI HAR Dataset/features_info.txt after extraction.*
  - **Acc**: Accelerometer
  - **Gyro**: Gyroscope
  - **XYZ**: Axis
  - **t**: Time
  - **f**: Frequency
  - **mean()**: Mean value
  - **std()**: Standard deviation
