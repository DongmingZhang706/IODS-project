# Dongming Zhang

# create the data of human for next week.

library(dplyr)

# Set the working directory
setwd('//ad.helsinki.fi/home/z/zhangdon/Desktop/Introduction to open data science/IODS-project/data')

# Read data
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

dim(hd) # 195 obs & 8 variables
dim(gii) # 195 obs & 10 variables

str(hd)
str(gii)

summary(hd)
summary(gii)

# Shorten the column names of the data

colnames(hd)[1:8] <- c('hdi_r', 'country', 'hdi', 'le_birth', 'ey_edu', 'my_edu', 'gni_per', 'gni_hdi')

colnames(gii)
colnames(gii)[1:10] <- c('gii_r', 'country', 'gii', 'mm_ratio', 'ado_br', 'pp_parlia', 'edu2f', 'edu2m', 'labf', 'labm')
colnames(gii)

# create 2 new variables in gii data

edu2_ratio <- gii$edu2f / gii$edu2m

gii <- mutate(gii, edu2_ratio)

lab_ratio <- gii$labf/gii$labm

gii <- mutate(gii, lab_ratio)

# join together the two datasets

human <- inner_join(hd, gii, by = 'country')

# save the data to a csv file
write.csv(human, file = 'human.csv', row.names = FALSE)

test <- read.table('human.csv', sep=',', header=TRUE)

str(test) # view the structure of test file
dim(test) # 195 obervations and 19 variables. Correct!!!
