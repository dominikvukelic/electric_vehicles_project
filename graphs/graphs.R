# Importing necessary libraries
library(ggplot2)
library(tidyverse)
library(scales)

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

# Aggregating counts of top speeds by brand
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


# Calculating percentages of BodyStyle
df_percent <- df %>%
  count(BodyStyle) %>%
  mutate(percentage = n / sum(n) * 100)

# Creating a Donut Chart for BodyStyle
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

# Checking unique values of Number_of_seats
unique_seats <- unique(df$Number_of_seats)

# Printing unique values
print(unique_seats)

# Counting the number of cars for each unique number of seats
seat_counts <- df %>%
  group_by(Number_of_seats) %>%
  summarise(Count = n())

# Creating the Bar Plot for Number of seats
ggplot(seat_counts, aes(x = factor(Number_of_seats), y = Count, fill = factor(Number_of_seats))) +
  geom_bar(stat = "identity", color = "black", show.legend = FALSE) +
  geom_text(aes(label = Count), vjust = -0.5) +  
  labs(title = "Count of Cars by Number of Seats",
       x = "Number of Seats",
       y = "Count") +
  scale_fill_brewer(palette = "Set3") +  
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 0, hjust = 1))


# Creating a Density Plot for Vehicle Prices and PowerTrain
ggplot(df, aes(x = Price_in_Euros, fill = PowerTrain)) +
  geom_density(alpha = 0.7) +
  labs(title = "Density Plot of Vehicle Prices by PowerTrain",
       x = "Price in Euros",
       y = "Density",
       fill = "PowerTrain") +
  theme_minimal()

# Finding the most common PowerTrain type
most_common_powertrain <- df %>%
  count(PowerTrain) %>%
  arrange(desc(n)) %>%
  slice(1) %>%
  pull(PowerTrain)

# Filtering the dataframe for the most common powertrain type
filtered_df <- df %>%
  filter(PowerTrain == most_common_powertrain)

# Calculating the average price for each brand
average_price <- filtered_df %>%
  group_by(Brand) %>%
  summarise(Avg_Price = mean(Price_in_Euros))

# Sorting the brands by average price in descending order
average_price <- average_price %>%
  arrange(desc(Avg_Price))

# Creating a Bar Chart for the average price for each brand
ggplot(average_price, aes(x = reorder(Brand, -Avg_Price), y = Avg_Price, fill = Brand)) +
  geom_bar(stat = "identity", color = "black", show.legend = FALSE) +
  labs(title = paste("Average Price of Electric Vehicles with", most_common_powertrain, "(most common) Powertrain by Brand"),
       x = "Brand",
       y = "Average Price (Euros)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 0, hjust = 0.5))

# Calculating the count of each PowerTrain type for each brand
powertrain_counts <- df %>%
  count(Brand, PowerTrain) %>%
  arrange(Brand, desc(n))

# Creating the Stacked Bar Chart for Vehicle Brands and PowerTrain
ggplot(powertrain_counts, aes(x = Brand, y = n, fill = PowerTrain)) +
  geom_bar(stat = "identity", color = "black", position = "stack") +
  labs(title = "Distribution of Electric Vehicle Brands by Powertrain Type",
       x = "Brand",
       y = "Count",
       fill = "PowerTrain") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))


# Calculating the count of each segment for each brand
segment_counts <- df %>%
  count(Brand, Segment) %>%
  arrange(Brand, desc(n))

# Creating the Stacked Bar Chart for Vehicle Brands and Segment
ggplot(segment_counts, aes(y = forcats::fct_rev(Brand), x = n, fill = Segment)) +
  geom_bar(stat = "identity", color = "black", position = "stack") +
  labs(title = "Distribution of Electric Vehicle Brands by Segment",
       x = "Count",
       y = "Brand",
       fill = "Segment") +
  theme_minimal() +
  theme(axis.text.y = element_text(angle = 0, hjust = 1))