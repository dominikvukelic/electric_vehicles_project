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

# Aggregate counts of top speeds by brand
speed_counts <- with(df, table(Brand, Top_speed_in_km_h))

# Creating a bar plot with brands included
barplot(speed_counts, beside = TRUE, col = rainbow(nrow(speed_counts)), main = "Distribution of Top Speeds of Electric Vehicles by Brand", xlab = "Top Speed (km/h)", ylab = "Count")
legend("topright", legend = rownames(speed_counts), fill = rainbow(nrow(speed_counts)))

# Creating a scatter plot of Acceleration vs. Top Speed
ggplot(df, aes(x = Acceleration_to_100km_h_in_seconds, y = Top_speed_in_km_h, color = Segment)) +
  geom_point() +
  labs(title = "Acceleration vs. Top Speed of Electric Vehicles",
       x = "Acceleration (s)",
       y = "Top Speed (km/h)") +
  theme_minimal()

# Creating a scatter plot of Efficiency vs. Range:
ggplot(df, aes(x = Efficiency_in_Wh_km, y = Range_in_km, color = PowerTrain)) +
  geom_point() +
  labs(title = "Efficiency vs. Range of Electric Vehicles",
       x = "Efficiency (Wh/km)",
       y = "Range (km)") +
  theme_minimal()


# Calculate percentages of BodyStyle
df_percent <- df %>%
  count(BodyStyle) %>%
  mutate(percentage = n / sum(n) * 100)

# Creating a donut chart for BodyStyle
ggplot(df_percent, aes(x = 2, y = percentage, fill = BodyStyle)) +
  geom_bar(stat = "identity", width = 1, color = "black") +
  coord_polar(theta = "y") +
  xlim(0.5, 2.5) +  # Adjust to create a donut shape
  geom_text(aes(label = sprintf("%.1f%%", percentage)), 
            position = position_stack(vjust = 0.5), size = 4) +
  labs(title = "Distribution of Vehicle Body Styles",
       fill = "Body Style") +
  theme_void() +
  theme(legend.position = "right")

