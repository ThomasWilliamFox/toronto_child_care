#### Preamble ####
# Purpose: Simulates data for child care spots in toronto's 25 wards 
# Author: Thomas Fox
# Date: 21 January 2024
# Contact: thomas.fox@mail.utoronto.ca
# License: MIT
# Pre-requisites: n/a
# Any other information needed? n/a


#### Workspace setup ####
library(tidyverse)


#### Build simulated data ####

set.seed(853)

# Simulate child care data 
# facilities - 1:1000
# wards - 1:25
# spots - 10:60

simulated_childcare_data <-
  tibble(
    sim_facility =
      rep(c(1:1000)), 
    
    sim_ward =  sample(
      x = c(1:25),
      size = 1000,
      replace = TRUE),
    
    sim_spots = sample(
      x = c(10:60),
      size = 1000,
      replace = TRUE)
  )

simulated_childcare_data

# Simulate ward census data 
# wards - 1:25 
# population under 14 - 10000:30000
# average household income - 60000:200000

simulated_census_data <-
  tibble(
    sim_ward =
      rep(c(1:25)), 
    
    sim_child_population =  sample(
      x = c(10000:30000),
      size = 25,
      replace = TRUE),
    
    sim_avg_hh_income = sample(
      x = c(60000:200000),
      size = 25,
      replace = TRUE)
  )

simulated_census_data 


#### Summarize simulated data ####

# Total child care spots per ward 
summary_sim_childcare_data <-
  simulated_childcare_data |> 
  summarise(sim_total_spots = sum(sim_spots),
            .by = sim_ward) 

summary_sim_childcare_data <- summary_sim_childcare_data[order(summary_sim_childcare_data$sim_ward),]

summary_sim_childcare_data


#### Graph simulated data ####

# Total child care spots per ward
summary_sim_childcare_data |>
  ggplot(aes(x = factor(sim_ward), y = sim_total_spots)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(x = "Ward", y = "Total Child Care Spots") 

# Total child population per ward  
simulated_census_data |>
  ggplot(aes(x = factor(sim_ward), y = sim_child_population)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(x = "Ward", y = "Child Population") 
 
# Average household income per ward 
simulated_census_data |>
  ggplot(aes(x = factor(sim_ward), y = sim_avg_hh_income)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(x = "Ward", y = "Average Household Income") 


#### Run tests on simulated data sets ####

# Test 1 - Verify number of wards in child care data 
sim_test_1_max <- max(simulated_childcare_data$sim_ward)
sim_test_1_min <- min(simulated_childcare_data$sim_ward)
sim_test_1 <- sim_test_1_max <= 25 && sim_test_1_min >= 1
sim_test_1

# Test 2 - Verify number of child care facilities
sim_test_2 <- nrow(simulated_childcare_data)
sim_test_2 == 1000

# Test 3 - Verify census child population maximum 
sim_test_3 <- max(simulated_census_data$sim_child_population)
sim_test_3 <= 30000

# Test 4 - Verify number of wards in census data 
sim_test_4 <- nrow(simulated_census_data)
sim_test_4 == 25

# Test 5 - Verify average household income 
sim_test_5_max <- max(simulated_census_data$sim_avg_hh_income)
sim_test_5_min <- min(simulated_census_data$sim_avg_hh_income)
sim_test_5 <- sim_test_5_max <= 200000 && sim_test_5_min >= 60000
sim_test_5

