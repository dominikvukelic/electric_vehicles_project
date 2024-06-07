# Importing necessary libraries
library(ggplot2)
library(tidyverse)  # Includes dplyr and forcats
library(scales)
library(ggrepel)
library(ggplotly)


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

# Aggregate counts of top speeds by brand
speed_counts <- with(df, table(Brand, Top_speed_in_km_h))

# Plot bar plot with brands included
barplot(speed_counts, beside = TRUE, col = rainbow(nrow(speed_counts)), main = "Distribution of Top Speeds of Electric Vehicles by Brand", xlab = "Top Speed (km/h)", ylab = "Count")
legend("topright", legend = rownames(speed_counts), fill = rainbow(nrow(speed_counts)))


