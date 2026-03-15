## Lab3b.R
## DATS1001 - Data Science for All
## STUDENT NAME: 
## DUE: February 24th at 11:59 PM
library(wbstats) 
library(dplyr) 
library(janitor)
library(vdemlite)
library(countrycode)
library(tidyr)

## First, we're going to grab data frames from the World Bank and the 
## V-Democracy data sets.

## Store the list of indicators in an object
indicators_WB <- c("flfp" = "SL.TLF.CACT.FE.ZS", "women_rep" = "SG.GEN.PARL.ZS") 
## flfp - Female Labor Force Participation
## women_rep - proportion of seats held by women in parliament

## Download the data from the World Bank
wb_dta <- wb_data(indicators_WB, mrv = 25) |> # most recent 25 years
  select(!iso2c) |> 
  rename(year = date) |> 
  mutate(
    flfp = round_to_fraction(flfp, denominator = 100), # round to nearest 100th
    women_rep = round_to_fraction(women_rep, denominator = 100) 
  )

## Do the same, but for V-Dem data
indicators_VD = c("v2x_gender", "v2x_gencl", "e_regionpol_6C")
vdem_dta <- fetchdem(indicators = indicators_VD, 
                     start_year = 2000, end_year=2020) |>
  rename(
    women_polymp = v2x_gender,
    women_civlib = v2x_gencl,
    region = e_regionpol_6C
  ) |>
  mutate(
    region = case_match(region, 
                        1 ~ "Eastern Europe", 
                        2 ~ "Latin America",  
                        3 ~ "Middle East",   
                        4 ~ "Africa", 
                        5 ~ "The West", 
                        6 ~ "Asia")
  )

## Adding ISO3 codes to the vdem data frame
vdem_dta <- vdem_dta |>    
  mutate(iso3c = countrycode(sourcevar = country_id, # what we are converting
                             origin = "vdem",         # we are converting from vdem
                             destination = "wb"))  |> # and converting to the WB iso3c code 
  relocate(iso3c, .after = country_id) # move iso3c column to the front of the data frame

## Problem 1 (5 points)
## Take a look at the two data frames we're using in this lab. Do you see any 
## columns that we can use as a key to merge these data frames together? 
## Answer as a comment.

## The two data frames both share iso3c and year.These can be used to merge the country-year observations.


## Problem 2 (10 points)
## Merge the two data frames on the column/s you identified in Problem 1, using
## left_join(). Which data frame is the left data frame, and which data frame is
## the right? How many rows are in your resulting data frame?
merged_dta <- wb_dta |>
  left_join(vdem_dta, by = c("iso3c", "year"))
##Left data frame: wb_dta
##Right data frame: vdem_dta
##Rows in merged_dta: 5425

## Problem 3 (15 points)
## Part A (3 points)
## Are there null values in your merged data frame from Problem 2? In which 
## columns are there null values? 
na_counts <- colSums(is.na(merged_dta))
na_counts

## Yes, there are null values in the merged data frame.
## Columns with null values are: women_rep, flfp, country_name, country_text_id, country_id, women_polymp,
## women_civlib, and region.

## Part B (6 points)
## Are there any columns in your merged data frame that are not worth keeping 
## for downstream analyses? Drop them from your data frame, using 
## select(-c(col1, col2, ..., coln))
merged_clean <- merged_dta |>
  select(-c(country_text_id, country_id, country_name))


## Part C (6 points)
## What do you think is the best course of action for dealing with the null
## values in this data set? Perform that action below. What are the final 
## dimensions of your data set?
## Rows before dropping NA
nrow(merged_clean)
merged_final <- merged_clean |>
  drop_na(flfp, women_rep, women_polymp, women_civlib)
dim(merged_final)
## I dropped rows with null values,flfp, women_rep, women_polymp, women_civlib.
## Final dimensions: 3200 rows and 8 columns.