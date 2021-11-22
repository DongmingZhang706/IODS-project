# Dongming Zhang
# 16/11/2021
# Week 3 exercise - logistic regression. Reference from DataCamp


# Set the working directory
setwd('//ad.helsinki.fi/home/z/zhangdon/Desktop/Introduction to open data science/IODS-project/data')

# Read data
math <- read.table('student-mat.csv', sep = ';' , header=TRUE)
str(math)
dim(math)

por <- read.table('student-por.csv', sep = ';', header = TRUE)
str(por)
dim(por)

# join the two data sets
library(dplyr)

# Define own id for both datasets
por_id <- por %>% mutate(id=1000+row_number()) 
math_id <- math %>% mutate(id=2000+row_number())

free_cols <- c('id', "failures","paid","absences","G1","G2","G3")

# The rest of the columns are common identifiers used for joining the datasets
join_cols <- setdiff(colnames(por_id),free_cols)

# merge the two datasets with the common identifiers
alc <- inner_join(math_id, por_id, by = join_cols, suffix = c(".math", ".por"))

# generate the not joined columns
notjoined <- colnames(math)[!colnames(math) %in% join_cols]


# compute the not joined columns and add them into alc 
for(column_name in notjoined) {
  two_columns <- select(alc, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  

  if(is.numeric(first_column)) {
    alc[column_name] <- round(rowMeans(two_columns))
  } else {
    alc[column_name] <- first_column
  }
}

# add the answers related to alcohol consumption
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2) %>% 
  mutate(alc, high_use = alc_use > 2)

glimpse(alc)

# save the data into folder
write.csv(alc, file = 'alc.txt', row.names = FALSE)

# read the txt file for testing
text1 <- read.table('alc.txt', sep=',', header=TRUE)

str(text1) # view the structure of test file
dim(text1) # 350 observations
  
