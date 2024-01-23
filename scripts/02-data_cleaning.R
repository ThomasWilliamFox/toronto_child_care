#### Preamble ####
# Purpose: Cleans raw Toronto child care and census data
# Author: Thomas Fox
# Date: 21 January 2024
# Contact: thomas.fox@mail.utoronto.ca
# License: MIT
# Pre-requisites: n/a
# Any other information needed? n/a

#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(janitor)

#### Clean data ####

# Read childcare data

childcare_data <- read_csv("inputs/data/raw_childcare_data.csv")
names(childcare_data)

# Clean child care data, all names to lower case
# Select center id, ward number, total spaces, and type(non-profit/commercial)
cleaned_childcare_data <- 
  clean_names(data) |>
  select(x_id, ward, totspace, auspice) 

# Summarize child data by total spots
summarized_child_care_data <-
  cleaned_childcare_data |>
  summarise(total_spots = sum(totspace),
            .by = ward) 

# Order summarized child care data by ward number
summarized_child_care_data <-
  summarized_child_care_data |>
  arrange(summarized_child_care_data, ward)
summarized_child_care_data

# Read and clean ward name data 

ward_name_data <- read_csv("inputs/data/raw_ward_names.csv")

ward_name_data <- 
  clean_names(ward_name_data)

ward_name_data


# Read and clean 2021 Canada census data

census_data <- read_csv("inputs/data/raw_census_data.csv")

# Get subset of data covering total population and population under 14 by ward 
population_data <- census_data[c(19:21),c(1,3:27)]

population_data

# Get subset of data covering average/total/and median household incomes by ward
income_data <- census_data[c(1383:1384),c(1,3:27)]
income_data

# Merges income and population subsets together 
census_data_merged <- rbind(population_data, income_data)
census_data_merged

# Transposes x and y axis  
cleaned_census_data_temp <- t(census_data_merged)

# Turns matrix from transposing into data frame 
cleaned_census_df <- 
  as.data.frame(cleaned_census_data_temp)

# Converts data frame to tibble 
cleaned_census_data <- tibble(cleaned_census_df)
cleaned_census_data

# Uses first row as names of variables 
cleaned_census_data <- cleaned_census_data |>
  row_to_names(row_number = 1)

# Adds column to indicate wards
cleaned_census_data <- 
  cleaned_census_data |> add_column(ward = 1:25, .before = "0 to 4 years")

# Makes ward numbers into characters
cleaned_census_data <-
  cleaned_census_data |>
  mutate(
    ward = as.character(ward)
  ) 

# Rename variable names 
cleaned_census_data <-
  cleaned_census_data |>
  rename(pop_0_to_4 = `0 to 4 years`,
         pop_5_to_9 = `5 to 9 years`,
         pop_10_to_14 = `10 to 14 years`,
         avg_hh_income = `Average total income of households in 2020 ($)`,
         med_hh_income = `Median total income of households in 2020 ($)`
         )

# Convert all numerical columns to int or num 
cleaned_census_data <-
  cleaned_census_data |>
  mutate(
    pop_0_to_4 = as.integer(pop_0_to_4),
    pop_5_to_9 = as.integer(pop_5_to_9),
    pop_10_to_14 = as.integer(pop_10_to_14),
    avg_hh_income = as.numeric(avg_hh_income),
    med_hh_income = as.numeric(med_hh_income)
  ) 


# Add total child care spots count and total child population to census data
merged_census_childcare <- cbind(cleaned_census_data, summarized_child_care_data["total_spots"])
merged_census_childcare <- cbind(merged_census_childcare, total_under_15 = rowSums(merged_census_childcare[2:4]))

#### Save data ####

# Save cleaned child care data 
write_csv(cleaned_childcare_data, "outputs/data/child_care_data.csv")

# Save cleaned ward census data 
write_csv(cleaned_census_data, "outputs/data/census_data.csv")

# Save cleaned ward name data 
write_csv(ward_name_data, "outputs/data/ward_names.csv")

# Save merged child care spots and ward census data 
write_csv(merged_census_childcare, "outputs/data/merged_ward_data.csv")

