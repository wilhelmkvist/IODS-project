Data wrangling for the next week’s data! (Max 5 points)
Create a new R script called create_human.R
Read the “Human development” and “Gender inequality” datas into R. Here are the links to the datasets:
  hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
and
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
Meta file for these datasets can be seen here and here are some technical notes. (1 point)
Explore the datasets: see the structure and dimensions of the data. Create summaries of the variables. (1 point)
Look at the meta files and rename the variables with (shorter) descriptive names. (1 point)
Mutate the “Gender inequality” data and create two new variables. The first one should be the ratio of Female and Male populations with secondary education in each country. (i.e. edu2F / edu2M). The second new variable should be the ratio of labour force participation of females and males in each country (i.e. labF / labM). (1 point)
Join together the two datasets using the variable Country as the identifier. Keep only the countries in both data sets (Hint: inner join). The joined data should have 195 observations and 19 variables. Call the new joined data "human" and save it in your data folder. (1 point)