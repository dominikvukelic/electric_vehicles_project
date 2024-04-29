# Importing necessary libraries
library(tidyverse)

# Specify the relative path to your dataset within the project
dataset_path <- "starting_file/EV_data.csv"

# Import the dataset using read.csv with a.strings parameter to indicate the values that should be treated as missing (blank)
df <- read.csv(dataset_path, na.strings = c("", "NA"))

# View the contents of a dataframe
View(df)

# Inspect the structure of the data
glimpse(df)


# Renaming Accel column to Acceleration
df <- df %>%
  rename(Acceleration = Accel)
