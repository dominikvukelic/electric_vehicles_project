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

# Convert Acceleration_to_100km_h_in_seconds column to numeric
df$Acceleration_to_100km_h_in_seconds <- as.numeric(df$Acceleration_to_100km_h_in_seconds)

# Renaming TopSpeed column to Top_speed_in_km_h
df <- df %>%
  rename(Top_speed_in_km_h = TopSpeed)

# Removing km/h value from Top_speed_in_km_h column
df <- df %>%
  mutate(Top_speed_in_km_h = gsub(" km/h", "", Top_speed_in_km_h))

# Convert Top_speed_in_km_h column to numeric
df$Top_speed_in_km_h <- as.numeric(df$Top_speed_in_km_h)

# Renaming Range column to Range_in_km
df <- df %>%
  rename(Range_in_km = Range)

# Removing km value from Range_in_km column
df <- df %>%
  mutate(Range_in_km = gsub(" km", "", Range_in_km))

# Convert Range_in_km column to numeric
df$Range_in_km <- as.numeric(df$Range_in_km)

# Renaming Efficiency column to Efficiency_in_Wh_km
df <- df %>%
  rename(Efficiency_in_Wh_km = Efficiency)

# Removing Wh/km value from Efficiency_in_Wh_km column
df <- df %>%
  mutate(Efficiency_in_Wh_km = gsub(" Wh/km", "", Efficiency_in_Wh_km))

# Convert Range_in_km column to numeric
df$Efficiency_in_Wh_km <- as.numeric(df$Efficiency_in_Wh_km)

# Renaming FastCharge column to Charge_in_km_h
df <- df %>%
  rename(Charge_in_km_h = FastCharge)

# Keeping only rows which contain km/h
df <- df %>%
  filter(grepl(" km/h", Charge_in_km_h))

# Removing km/h value from Charge_in_km_h column
df <- df %>%
  mutate(Charge_in_km_h = gsub(" km/h", "", Charge_in_km_h))

# Convert Charge_in_km_h column to numeric
df$Charge_in_km_h <- as.numeric(df$Charge_in_km_h)