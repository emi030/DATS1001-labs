## Lab4.R
## DATS1001 - Data Science for All
## STUDENT NAME: 
## DUE: Thursday, March 19th at 11:59 PM
library(palmerpenguins)
library(tidyverse)
library(ggplot2)

## Problem 1 (30 points) Describing Distributions
## First, let's start by plotting different distributions of data, then describe 
## the shape of the data that you see. What do you think is causing the shape?
## Be sure to answer in a comment.

## Part A (10 points) - Penguins and body mass
## Plot a histogram of the variable body_mass_g from the penguins data set. Set 
## bins = 20. Be sure to include graph labels. Describe the shape you see. What 
## do you think is causing the shape?
penguins |> 
  drop_na(body_mass_g) |> 
  ggplot(aes(x = body_mass_g)) +
  geom_histogram(bins = 20) +
  labs(
    title = "Penguins: Body Mass (g)",
    x = "Body mass (g)",
    y = "Count"
  )
## The shape has multiple peaks
## Because this histogram includes multiple species with different 
## typical body masses

## Part B (10 points) - Old Faithful Waiting Times
## Plot a histogram of the variable waiting from the faithful data set. Set 
## bins = 30. Be sure to include graph labels. Describe the shape you see. What 
## do you think is causing the shape?
faithful |>
  ggplot(aes(x = waiting)) +
  geom_histogram(bins = 30) +
  labs(
    title = "Old Faithful: Waiting Times Between Eruptions",
    x = "Waiting time (minutes)",
    y = "Count"
  )
## The shape is bimodal.
## Because it has two behaviors: short waits and long waits.


## Part C (10 points) - Diamond Prices
## Plot a histogram of the variable price from the diamonds data set. Set
## bins = 50. Be sure to include graph labels. Describe the shape you see. What  
## do you think is causing the shape?
diamonds |>
  ggplot(aes(x = price)) +
  geom_histogram(bins = 50) +
  labs(
    title = "Diamonds: Price Distribution",
    x = "Price (USD)",
    y = "Count"
  )

## The shape is right-skewed and has a long tail to the right
## Because most diamonds in this set have lower prices, 
## only some diamonds are expensive


## Problem 2 (30 points) Measuring Distributions
## Below are two variables, x is a vector of integers, where data is a 
## tibble containing one column (our values in x). Some of the summary stat 
## functions in R will expect either a vector or a data frame/tibble.

x <- c(10, 2, 25, 8, 6, 12, 4) 
data <- tibble(x)

## Part A (8 points) - Summary Stats
## Calculate the following summary statistics:
## 1) median
## 2) Q1 and Q3
## 3) IQR
## 4) Lower and upper fences

## 1) median
med <- median(x)
med
## the medium is 8

## 2) Q1 and Q3
q1 <- quantile(x, 0.25, names = FALSE)
q3 <- quantile(x, 0.75, names = FALSE)
q1
q3
## Q1 is 5, Q3 is 11

## 3) IQR
iqr_val <- IQR(x)
iqr_val
## IQR is 6

## 4) Lower and upper fences
lower_fence <- q1 - 1.5 * iqr_val
upper_fence <- q3 + 1.5 * iqr_val
lower_fence
upper_fence
## lower fence is -4, upper fence is 20


## Part B (4 points) - Outlier Identification
## According to the statistics you calculated in part A, does this data set have 
## any potential outliers? If so, which data points? You may answer in a comment.

## Using the fences (-4, 20), any value > 20 or < -4 is a potential outlier.
x[x > upper_fence | x < lower_fence]
## 25 is a potential outlier.


## Part C (8 points) - Box Plot
## Create a box plot of the given data, using geom_boxplot(). Be sure to include
## appropriate figure labels. Does the box plot you created match the summary 
## statistics you calculated in part A? Be sure to answer in a comment.
data |>
  ggplot(aes(x = "", y = x)) +
  geom_boxplot() +
  labs(
    title = "Box Plot of x",
    x = "variables",
    y = "x"
  )
## Yes, it matches the summary statistics from Part A.
## The median line appears at ~8, the box spans from Q1 (~5) to Q3 (~11),
## and the point at 25 is shown as an outlier beyond the upper fence.



## Part D (5 points) - Standard Deviation
## Calculate the standard deviation of this data set. In plain English, what 
## does value this tell you about the data set at hand? You may answer in a 
## comment.
sd_val <- sd(x)
sd_val
## The standard deviation of this data set is 7.612646 which means that on 
## average, each data is about 7.61 units away from the mean.
## This indicates the data is fairly spread out.

## Part E (5 points) - Z-Scores
## Calculate the z-scores for each observation in the data set. According to 
## your z-scores, are any of these observations outliers? Is this different
## from what you observed in part B and C? Be sure to answer in a comment.
mean_val <- mean(x)
z_scores <- (x - mean_val) / sd_val
z_scores

## The z-score for 25 is approximately 2.03, 
##which exceeds the threshold of |z| > 2,
## so it is flagged as a potential outlier.
## This is consistent with Part B and C because both the fence method
##and the box plot identified 25 as the only potential outlier.