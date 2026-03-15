## Lab3a.R
## DATS1001 - Data Science for All
## STUDENT NAME: Emi Rivera
## DUE: February 24th at 11:59 PM
library(dplyr)
library(vdemdata)

## Below I have defined the democracy object, which contains the data used in
## this lab
democracy <- vdem

## Problem 1 (5 points)
## Filter the data set to only include observations where the year is 2000 or 
## later. Save this as a variable to use later in this lab.
democracy_2000 <- democracy |>
  filter(year >= 2000)


## Problem 2 (10 points)
## Now try grouping this data set by country_name. Calculate the following 
## summary statistics for each country for the data frame from Problem 1. 
## Remember to setna.rm = TRUE so that your program automatically drops the rows
## where the value is missing. Save your result to an object to answer question 
## 3.

## 1) median value of v2x_polyarchy. Name this column "polyarchy_median"
## 2) max value of v2x_libdem. Name this column "libdem_max"
## 3) standard deviation of v2x_gender. Name this column "gender_sd" 
## 4) min value of e_gdppc. Name this column "gdp_pc"
democracy_summary <- democracy_2000 |> 
  group_by(country_name) |>
  summarize(
    polyarchy_median = median(v2x_polyarchy, na.rm = TRUE),
    libdem_max       = max(v2x_libdem, na.rm = TRUE),
    gender_sd        = sd(v2x_gender, na.rm = TRUE),
    gdp_pc           = min(e_gdppc, na.rm = TRUE)
  )


## Problem 3 (5 points)
## Using the result from Problem 2, sort your object using arrange(). What is 
## the country name for the smallest polyarchy_median? 
## You may answer in a comment

democracy_summary_sorted <- democracy_summary |>
  arrange(polyarchy_median)
##country for the smallest polyarchy_median: Saudi Arabia. 

## Problem 4 (10 points)
## Now, use your dataframe from Problem 1 and the across() function to calculate
## the mean values for v2x_polyarchy, v2x_libdem, v2x_gender, and e_gdppc
## across countries. Sort your rows using arrange() by the mean v2x_gender 
## value, from largest to smallest. Which country has the highest v2x_gender 
## mean? You may answer in a comment

democracy_means <- democracy_2000 |>
  group_by(country_name) |>
  summarize(
    across(
      c(v2x_polyarchy, v2x_libdem, v2x_gender, e_gdppc),
      ~ mean(.x, na.rm = TRUE),
      .names = "{.col}_mean"
    )
  ) |>
  arrange(desc(v2x_gender_mean))
##country with highest v2x_gender mean: Denmark.

