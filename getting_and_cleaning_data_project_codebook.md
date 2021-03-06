Raw Data

The raw data for this project is accelerometer data collected from the
Samsung Galaxy S smartphone, and was provided to us at the links below:

Data file:
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>
CodeBook:
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>
This data included both the raw sampled data (folder ../Inertial
Signals) and features apparently based on the raw data. For the purpose
of this project, I am only looking at the features, not the raw data.

There are 3 types of files:

x: rows of feature measurements y: the activity labels corresponding to
each row of X. Encoded as numbers. subject: the subjects on which each
row of X was measured. Encoded as numbers. In addition, to determine
which features are required, we look at the list of features:

features.txt The encoding from activity labels ids to descriptive names.

activity\_labels.txt Data load

The Y, S and X data is loaded from each of the training and test
datasets, directly as their final type. Only the columns of interest
from X are loaded, that is the mean() and sd() columns. We determine the
columns by examining the feature names (from features.txt) for patterns
“-mean()” or “-std()”. All of these files are fixed format text files.

Transformation

The activity descriptions are joined to the activity label data (y). The
corresponding training and test datasets are concatenated, and then
columns for subject and activitylabel (description) are appended (by row
number) to the data. This result is output as
result\_combinedDataSet.csv.

The data is further subsetted to only include the activity, subject, and
the mean() features. Again these are determined by looking for “-mean()”
in the feature name. The data is then reduced with ddply() to
(activity,subject) -&gt; colMeans() As it was not specified, missing
combinations of activity and subject are output, with value NA. The
column names are tidied by removing the “mean()” string, etc. This
result is output as newdata.csv
