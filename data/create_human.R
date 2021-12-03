# Wilhelm Kvist 29 Nov 2021
# This script is created as part of exercises 4 and 5 for the IODS course in the Fall of 2021.
# The human dataset contains country-specific indicators relating to human development. The Human Development Index (HDI) is calculated by the UNDP and is a summary measure of average achievement in key dimensions of human development. Variables include data on Gross National Income per capita, life expectancy, expected years of education and female represenatation in parliament, secondary education and the labour force.
# A description of variables can be found here: https://raw.githubusercontent.com/TuomoNieminen/Helsinki-Open-Data-Science/master/datasets/human_meta.txt
# Original data: http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt
# Technical notes on calculations: http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf.
# Source: United Nations Development Programme.

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
colnames(hd)[4] <- "LifeExp"
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
human <- read.csv("./data/human.csv", stringsAsFactors = F)

# Confirming the structure of the imported dataset
str(human)

#--------Wrangling for exercise 5--------

# Mutate the data: transform the Gross National Income (GNI) variable to numeric
library(stringr)
human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric

# Exclude unneeded variables: keep only select columns
keep <- c("Country", "EduRatio", "LabRatio", "EducExp", "LifeExp", "GNI", "Matmort", "AdolBirthRt", "ParlRep")
human <- select(human, one_of(keep))

# Remove all rows with missing values
human <- filter(human, complete.cases(human) == TRUE)

# Remove the observations which relate to regions instead of countries. (Rows 1 to 155 seem to be related to countries.)
human <- human[1:155, ]

# Define the row names of the data by the country names and remove the country name column from the data.
rownames(human) <- human$Country
human <- select(human, -Country)

# The data should now have 155 observations and 8 variables. Confirming the dimensions.
dim(human)

# Save the human data in your data folder including the row names. You can overwrite your old ‘human’ data.
write.csv(human, file = "./data/human.csv", row.names = T)

# Reading the data again
human <- read.csv("./data/human.csv", stringsAsFactors = F, row.names = 1)

# Confirming the structure of the imported dataset
str(human)
head(human)

# I note that I had to include the 'row.names = 1' argument in the read.csv command in order to get the row names proper order when importing the data back. The data seems to look fine.