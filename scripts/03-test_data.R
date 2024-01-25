#### Preamble ####
# Purpose: Tests cleaned data sets 
# Author: Thomas Fox 
# Date: 25 January 2024
# Contact: thomas.fox@mail.utoronto.ca
# License: MIT
# Pre-requisites: run 01-download_data.R and 02-data_cleaning.R
# Any other information needed? n/a


#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(janitor)

#### Load Cleaned Data Sets ####

# read cleaned child care data
test_child_care = read_csv(
  file = "outputs/data/child_care_data.csv",
  show_col_types = FALSE
)

# read cleaned census data
test_census_data = read_csv(
  file = "outputs/data/census_data.csv",
  show_col_types = FALSE
)

# read cleaned merged child care/census data
test_census_childcare_data = read_csv(
  file = "outputs/data/merged_ward_data.csv",
  show_col_types = FALSE
)

# read ward names
test_ward_names = read_csv(
  file = "outputs/data/ward_names.csv",
  show_col_types = FALSE
)


#### Test data ####

# Test cleaned child care data 

if (test_child_care.length != 1064) {
  
}
test_child_care 

test_census_data 

test_census_childcare_data

test_ward_names


