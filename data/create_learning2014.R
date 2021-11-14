# Dongming Zhang
# 12/11/2021
# Week 2 exercise-Regression and model validation


# read data into R
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# 1.watch the dimension and structure of dataset
dim(lrn14) # 183 observations and 60 variables
str(lrn14) # all variables are int. Except that gender is chr.

# 2.create an analysis dataset

library(dplyr) # access dplyr library

# scaling the column "Attitude"
lrn14$attitude <- lrn14$Attitude / 10


# questions about deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# add the deep columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# add the surf columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# add the stra columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

dim(lrn14) # now varibales are increased to 64

# select the columns
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(lrn14, one_of(keep_columns))

dim(learning2014) # 183,7

# correct the column names and choose points is greater than zero
colnames(learning2014)[2] <- "age"
colnames(learning2014)[7] <- "points"
learning2014 <- filter(learning2014, points > 0)

dim(learning2014) # 166,7

# Now, it is ready for analysis.

# save it to data fold

setwd('data/')
write.csv(learning2014, file = 'learning2014.txt', row.names = FALSE)

# read the txt file for testing
text1 <- read.table('learning2014.txt', sep=',', header=TRUE)

head(text1) # view the test file
str(text1) # view the structure of test file
dim(text1) # 166 observations, 7 variables. the test file has the same dimension with completed file
