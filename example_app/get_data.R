# script to load in data and prepare for use in the app

library(dplyr)

# load data
penguins <- read.csv("/dbfs/mnt/lab/unrestricted/R_training/penguins.csv")

# clean data - remove NA values
data <- penguins %>% 
  filter(!is.na(sex)) 

# create dataset for average flipper length
flipper_length <- data %>% 
  select(species, flipper_length_mm, year) %>% 
  group_by(species, year) %>% 
  summarise(mean_flipper_mm = mean(flipper_length_mm))


# create separate dataset for each species
adelie <- data %>% 
  filter(species == "Adelie")

gentoo <- data %>% 
  filter(species == "Gentoo")

chinstrap <- data %>% 
  filter(species == "Chinstrap")
