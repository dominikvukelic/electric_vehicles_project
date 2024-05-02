# Importing necessary libraries
library(ggplot2)
library(tidyverse)  # Includes dplyr and forcats
library(scales)
library(ggrepel)


# Specifying the relative path to your dataset within the project
dataset_path <- "cleaned_starting_file/EV_Data_cleaned.csv"

# Importing the dataset using read.csv with na.strings parameter to indicate missing values
df <- read.csv(dataset_path, na.strings = c("", "NA"))

# Viewing the contents of a dataframe
View(df)

names(df)

# Creating a bar chart of brands
ggplot(df, aes(x = Brand, fill = Brand)) +
  geom_bar(colour = "black", show.legend = FALSE) +
  geom_text(stat = "count", aes(label = ..count..), vjust = -0.5) +
  labs(title = "Count of Electric Vehicle Brands",
       x = "Brand",
       y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# Summarize the data to calculate counts
counts <- df %>%
  group_by(Top_speed_in_km_h) %>%
  summarize(count = n())

# Create a horizontal bar plot of top speeds
ggplot(df, aes(x = Top_speed_in_km_h, fill = as.factor(Top_speed_in_km_h))) +
  geom_bar(color = "black") +
  geom_text(stat = "count", aes(label = after_stat(count)), hjust = -0.1, color = "black") +
  labs(title = "Distribution of Top Speeds of Electric Vehicles",
       y = "Top Speed (km/h)",
       x = "Count") +
  theme_minimal() +
  coord_flip() +
  theme(legend.position = "none")



