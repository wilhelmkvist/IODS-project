# Wilhelm Kvist 10 Dec 2021
# This script is created as part of exercise 6 for the IODS course at University of Helsinki in the Fall of 2021.

# Reading BRPS and RATS
BPRS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep=" ")
RATS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep = "\t")

# Exploring the data structures
head(BPRS)
head(RATS)
str(BPRS)
str(RATS)

# Summarizing briefly the variables
summary(BPRS)
summary(RATS)

# Convert the categorical variables of both data sets to factors.
BPRS$treatment <- as.factor(BPRS$treatment)
BPRS$subject <- as.factor(BPRS$subject)
RATS$ID <- as.factor(RATS$ID)
RATS$Group <- as.factor(RATS$Group)

# Accessing packages dplyr and tidyr
library(dplyr)
library(tidyr)

# Converting datasets to long form
BPRSL <- BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <- BPRSL %>% mutate(week = as.integer(substr(BPRSL$weeks, 5,6))) # Extracting the week number
RATSL <- RATS %>% gather(key = WD, value = Weight, -ID, -Group) %>% mutate(Time = as.integer(substr(WD,3,4))) 

# dropping columns
BPRSL <- select(BPRSL, -weeks)
RATSL <- select(RATSL, -WD)

# relocating columns
BPRSL <- BPRSL %>% relocate(week, .before = bprs)
RATSL <- RATSL %>% relocate(Time, .before = Weight)

# Examining the structure of the new datasets, looking at the heads and summarizing variables
str(BPRSL) #I ask myself if week should have been a factor as well? I contend that it's not, since it is a continuous value.
head(BPRSL)
summary(BPRSL)
str(RATSL)
head(RATSL)
summary(RATSL)

#---Writing the files---

# Setting the working directory
setwd("~/Documents/IODS-project")

# Writing the csv files to the data subfolder
write.csv(BPRSL, file = "./data/bprsl.csv", row.names = F)
write.csv(RATSL, file = "./data/ratsl.csv", row.names = F)

# Reading the data again
BPRSL_imp <- read.csv("./data/bprsl.csv", stringsAsFactors = T)
RATSL_imp <- read.csv("./data/ratsl.csv", stringsAsFactors = T)

# Confirming the structure of the imported datasets
str(BPRSL_imp)
str(RATSL_imp)

# If I wanted to use the imported versions, I would still need to convert the categorical variables of both data sets to factors.
