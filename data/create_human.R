# Dongming Zhang

# create the data of human for week 5 and data wrangling for week 5.

# data link "http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv" and "http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv"

library(dplyr)
library(stringr)

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
dim(test) # 195 observations and 19 variables. Correct!!!


# *Week 5 data wrangling* 
# Read data from the folder

setwd('//ad.helsinki.fi/home/z/zhangdon/Desktop/Introduction to open data science/IODS-project/data')
human <- read.table('human.csv', sep=',', header=TRUE)
str(human)
dim(human)

# There are 195 observations and 19 variables in the human data. According the instructions from last week, the column names of data had been changed. 
# For example, 'gni_per' is gross national income per capita;
# 'le_birth' is life expectancy at birth;
# 'ey_edu' is expected years of schooling;
# 'mm_ratio' is maternal mortality ratio;
# 'ado_br' is adolescent birth rate;
# 'pp_parlia' is percentage of female representatives in parliament;
# 'edu2f' is proportion of females with at least secondary education;
# 'edu2m' is proportion of males with at least secondary education;
# 'labf' is proportion of females in the labor force;
# 'labm' is proportion of males in the labor force;
# 'edu2_ratio' is 'edu2f' / 'edu2m';
# 'lab_ratio' is 'labf' / 'labm'.

# transform GNI variable
GNI <- str_replace(human$gni_per, pattern=",", replace ="") %>% as.numeric
human <- mutate(human, GNI)
str(human) # GNI was changed to numeric and added into the human data

# exclude unneeded variables
keep <- c('country', 'edu2_ratio', 'lab_ratio', 'le_birth', 'ey_edu', 'GNI', 'mm_ratio', 'ado_br', 'pp_parlia')
human <- dplyr::select(human, one_of(keep))

# remove the NA values
complete.cases(human)
data.frame(human[-1], comp = complete.cases(human))
human <- filter(human, complete.cases(human))
str(human)

# remove the regions in human data
tail(human, 10)
last <- nrow(human) - 7
human <- human[1:last, ]

# save the human data
rownames(human) <- human$country
human <- dplyr::select(human, -country) 
str(human) # there are 155 observations and 8 variables in the data.
write.csv(human, file = 'human.csv', row.names = TRUE)

