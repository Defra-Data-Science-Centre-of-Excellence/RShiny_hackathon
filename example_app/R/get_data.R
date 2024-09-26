# script to load in data and prepare for use in the app
library(dplyr)

# loading the data from the data lake works when you run the app locally, 
# but to publish on the posit server you need to have the data saved 
# in your environment.
# The code below needs running once before publishing. 
# After that you just need to read the data from the Data folder

# # load data
# penguins <- read.csv("/dbfs/mnt/lab/unrestricted/R_training/penguins.csv")
# 
# # clean data - remove NA values
# data <- penguins %>%
#   filter(!is.na(sex))
# 
# write.csv(data, "example_app/Data/cleaned_penguins_data.csv")

data <- read.csv("Data/cleaned_penguins_data.csv")
