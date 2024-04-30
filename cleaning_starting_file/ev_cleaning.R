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

# Renaming Acceleration column to Acceleration_to_100km_h_in_seconds
df <- df %>%
  rename(Acceleration_to_100km_h_in_seconds = Acceleration)

# Removing sec value from Acceleration_to_100km_h_in_seconds column
df <- df %>%
  mutate(Acceleration_to_100km_h_in_seconds = gsub(" sec", "", Acceleration_to_100km_h_in_seconds))

# Convert the column to numeric
df$Acceleration_to_100km_h_in_seconds <- as.numeric(df$Acceleration_to_100km_h_in_seconds)

# Renaming TopSpeed column to Top_speed_in_km/h
df <- df %>%
  rename(Top_speed_in_km_h = TopSpeed)

# Removing km/h value from Top_speed_in_km_h column
df <- df %>%
  mutate(Top_speed_in_km_h = gsub(" km/h", "", Top_speed_in_km_h))