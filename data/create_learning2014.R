# Wilhelm Kvist 10 Nov 2021
# I created this script in order to complete exercise 1 of the assignments for week 2 on the IODS course in the Fall of 2021.

# read the data into memory
learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

#Summation of the dataset
str(learning2014)

#Comment: The created learning2014 dataset includes 183 observations of 60 variables, nearly all are numeric, single-digit values (grades 1-5). Age, Attitude and Points include double-digit values. Gender is binary, F/M.

#3. Create an analysis dataset with the variables gender, age, attitude, deep, stra, surf and points.
# Access the dplyr library
library(dplyr)

deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
deep_columns <- select(learning2014, one_of(deep_questions))
learning2014$deep <- rowMeans(deep_columns)
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
strategic_columns <- select(learning2014, one_of(strategic_questions))
learning2014$stra <- rowMeans(strategic_columns)
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
surface_columns <- select(learning2014, one_of(surface_questions))
learning2014$surf <- rowMeans(surface_columns)

# Scaling all combination variables

# create column 'attitude' by scaling the column "Attitude"
learning2014$attitude <- learning2014$Attitude / 10

#Exclude observations where the exam points variable is zero. 
learning2014 <- filter(learning2014, points > 0)

#renaming 'Age' to 'age'
colnames(learning2014)[57] <- "age"
#renaming 'Points' to 'points'
colnames(learning2014)[59] <- "points"

#keeping only select columns
keep_columns <- c("gender","age","attitude", "deep", "stra", "surf", "points")
learning2014 <- select(learning2014, one_of(keep_columns))
str(learning2014)

#Set the working directory of you R session the iods project folder
setwd("~/Documents/IODS-project")

#Write the csv file to the data subfolder
write.csv(learning2014, file = "./data/learning2014.csv", row.names = F)

#Read the data again
import_data <- read.csv("./data/learning2014.csv", stringsAsFactors = T)

#Confirm  that the structure of the data is correct
str(import_data)
head(import_data)

