# IODS course, exercise 3
# Wilhelm Kvist 15 Nov 2021
# This is a wrangling script to join together the two csv files included in the Student Performance Data Set, available at: https://archive.ics.uci.edu/ml/datasets/Student+Performance
# The joining solution used here is almost entirely adapted from Reijo Sund's wrangling script provided with the course materials.

# Read the data into memory
studentmat <- read.table("data/student-mat.csv", sep=";", header=TRUE)
studentpor <- read.table("data/student-por.csv", sep=";", header=TRUE)

# Summation of the dataset
str(studentmat)
str(studentpor)

# Joining columns
exclude_cols <- c("failures","paid","absences","G1","G2","G3")
join_cols <- setdiff(colnames(studentmat),exclude_cols)
total <- merge(studentmat,studentpor,by=join_cols, suffixes = c(".math",".por"))
str(total)
glimpse(total)

# Combine duplicated answers

# create a new data frame with only the joined columns
alc <- select(total, one_of(join_cols))

# for every column name not used for joining...
for(column_name in exclude_cols) {
  # select two columns from 'total' with the same original name
  two_columns <- select(total, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data
glimpse(alc)

# Take the average of the answers related to weekday and weekend alcohol consumption to create a new column 'alc_use' to the joined data. 
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# Use 'alc_use' to create a new logical column 'high_use' which is TRUE for students for which 'alc_use' is greater than 2
alc <- mutate(alc, high_use = alc_use > 2)

# Glimpse at the joined and modified data to make sure everything is in order.
glimpse(alc)

# Save the joined and modified data set to the ‘data’ folder
write.csv(alc, file = "./data/alc.csv", row.names = F)