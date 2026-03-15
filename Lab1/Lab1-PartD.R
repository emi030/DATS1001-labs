## Lab1-PartD.R
## DATS1001 - Data Science for All
## STUDENT NAME: 
## DUE: January 23rd 11:59 PM
library(readr)
library(dplyr)
library(ggplot2)

## Problem 1 (5 points) Read the data from the film.csv file downloaded
## from Blackboard. How many observations or samples are there in the dataset? 
## How many columns? You may leave your answer in a comment.
## 1659 obs, 10 columns

## Problem 2 (5 points) How many films in this list were released after 1988?
setwd("~/Desktop/DataScienceForAll")
films <- read_csv2("film.csv")
films_select<- films |> filter(Year>=1988)
## 542 films released after 1988 

## Problem 3 (5 points) How many films were released after 1988 but before 1990?
films_select<- films |> filter(Year>1988, Year<1990)
## 101 films released after 1988 before 1990

## Problem 4 (5 points) Create a new column in the original film dataframe you
## defined in problem 1, and name it "Age". Calculate the age of the movie in 
## 2026. 
films <- films |> mutate(Age = 2026 - Year)


## Problem 5 (5 points) Below is code that creates a bar chart visualization of 
## total film popularity by genre. Change the color of the bar chart.
## ggplot2 color info: https://sape.inf.usi.ch/quick-reference/ggplot2/colour
ggplot(data=films, aes(x = Subject, y = Popularity)) + 
  geom_col(fill="maroon3") 

## Problem 6 (5 points) Create a simple scatter plot that displays the 
## Year on the X-axis and Popularity on the Y-axis. 
## ggplot2 layers info: https://ggplot2.tidyverse.org/reference/index.html#layers
ggplot(data=films, aes(x = Subject, y = Popularity)) + 
  geom_point(fill="maroon3") 
