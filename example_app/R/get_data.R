# script to load in data and prepare for use in the app
library(dplyr)

# load data
penguins <- read.csv("/dbfs/mnt/lab/unrestricted/R_training/penguins.csv")

# clean data - remove NA values
data <- penguins %>% 
  filter(!is.na(sex)) 