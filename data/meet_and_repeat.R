# week6 meet_and_repeat

# name: Dongming Zhang

# data: 08/12/2021


# Set the working directory
setwd('//ad.helsinki.fi/home/z/zhangdon/Desktop/Introduction to open data science/IODS-project/data')

library(dplyr)
library(tidyr)

# load the data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =' ', header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep = '\t', header = T)

str(BPRS) # 40 observations and 11 variables in BPRS, column names are treatment, subject and week0 to week8
str(RATS) # 16 observations and 13 variables in RATS, column names are ID, Group, WD1 to WD64 by every 7 days

#save the data
write.csv(BPRS, file = 'BPRS.txt', row.names = FALSE)
write.csv(RATS, file = 'RATS.txt', row.names = FALSE)

# all values are integer numbers. Apart from the key information like 'treatment' or 'ID', 
# other variables are the serial timelines such as week0 to week8 in BPRS and rat body weight at 1 day to 64 day in RATS.

# Factor the categorical variables
# In BPRS, treatment and subject are the categorical variables. In RATS, ID and Group are the categorical variables.
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

str(BPRS)
str(RATS) # now, the categorical variables are factors.

# convert the data to long form and extract the week and WD in those two data sets
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)  
RATSL <- RATS %>% gather(key = WD, value = Weight, -ID, -Group) # the data is long form now, extract the numbers of key values to the new columns

BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(BPRSL$weeks,5,5)))
RATSL <- RATSL %>% mutate(Time = as.integer(substr(RATSL$WD,3,4)))

glimpse(BPRSL)
glimpse(RATSL)

# After wrangling, the rows of data sets are increased to 360 for BPRS and 175 for RARS. 
# In BPRSL, the data is categorized according to the week time. On week0, treatment1 is for 20 subjects and treatment2 is for 20 subjects.
# In RATSL, the data is categorized according to WD, the day of weighting. For example, at WD1, ID is from 1 to 16, their groups are from 1 to 3.

# save the data for analysis
write.csv(BPRSL, file = 'BPRSL.txt', row.names = FALSE)
write.csv(RATSL, file = 'RATSL.txt', row.names = FALSE)
