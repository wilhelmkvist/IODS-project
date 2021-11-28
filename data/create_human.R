# Wilhelm Kvist 29 Nov 2021
# This script is created as part of exercise 4 for the IODS coursein the Fall of 2021.

# Reading “Human development” and “Gender inequality”
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Exploring the dimensions of the datasets
dim(hd)
dim(gii)

# Acquiring an understanding of the values entered
head(hd)
head(gii)

# Creating summaries for the datasets
summary(hd)
summary(gii)

# Renaming columns
colnames(hd)[3] <- "HDI"
colnames(hd)[4] <- "Lifeexp"
colnames(hd)[5] <- "EducExp"
colnames(hd)[6] <- "EducMean"
colnames(hd)[7] <- "GNI"
colnames(hd)[8] <- "GNI_HDI"
colnames(gii)[3] <- "GII"
colnames(gii)[4] <- "Matmort"
colnames(gii)[5] <- "AdolBirthRt"
colnames(gii)[6] <- "ParlRep"
colnames(gii)[7] <- "edu2F"
colnames(gii)[8] <- "edu2M"
colnames(gii)[9] <- "labF"
colnames(gii)[10] <- "labM"

# Mutating 'Gender inequality'
library(dplyr)
gii <- mutate(gii, EduRatio = edu2F / edu2M)
gii <- mutate(gii, LabRatio = labF / labM)

# Joining the two datasets using the variable Country as identifier.
human <- inner_join(hd, gii, by = "Country", suffix = c(".hd", ".gii"))

# Moving the Country column first
human <- human %>% relocate(Country)

# Setting the working directory
setwd("~/Documents/IODS-project")

# Writing the csv file to the data subfolder
write.csv(human, file = "./data/human.csv", row.names = F)

# Reading the data again
import_data <- read.csv("./data/human.csv", stringsAsFactors = F)

#Confirm the structure of the imported dataset
str(import_data)
