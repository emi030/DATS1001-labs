## Lab2.R
## DATS1001 - Data Science for All
## STUDENT NAME: 
## DUE: February 5th at 11:59 PM
library(readr)
library(ggplot2)
library(dplyr)
library(tidyr)
library(forcats)

## For this lab we will be working with the a few data sets included in base R. 
## For problems 1 and 2, we will use the Motor Trend Car Road Tests data.
cardata <- as.data.frame(mtcars) ## convert to df
cardata$car <- rownames(cardata) ## add a new column "car" from the rownames
cardata$cyl <- factor(x=cardata$cyl) ## converts a number col to a category col
View(cardata)                    ## run this line to view the data  

## Problem 1 (10 points) Bar chart
## The code below contains a bar chart with the car model on the x-axis and the
## MPG on the y-axis. It is quite hard to read the car model names in this
## orientation! Flip the coordinates so that the labels are legible. You may 
## either edit the code definition for bar_chart directly or add changes to your 
## bar_chart object.
bar_chart <- ggplot(cardata, aes(x =mpg, y=fct_reorder(car, -mpg))) + 
  labs(
    x = "Miles per Gallon (mpg)",
    y = "Car Model", 
    title = "MPG by Car Model", 
  ) + 
  geom_col()
  
bar_chart

## Problem 2 (20 points) Histogram chart
## Part A (10 points)
## Using the cardata df, plot a histogram below where the x-axis is MPG. Add 
## labels to your plot to match the labels for your plot in Problem 1. Set your
## bins = 15.

# create histogram
hist_plot <- ggplot(cardata, aes(x = mpg)) +
  geom_histogram(bins = 15) +
  labs(
    x = "Miles per Gallon (mpg)",
    y = "Count",
    title = "Distribution of MPG"
  )

hist_plot

  
## Part B (10 points)
## Now we will polish the figure we created in Part A. Set your fill = cyl, or 
## the number of cylinders in the engine. Add a any theme you wish.

hist_plot_b <- ggplot(cardata, aes(x = mpg, fill = cyl)) +
  geom_histogram(bins = 15) +
  labs(
    x = "Miles per Gallon (mpg)",
    y = "Count",
    title = "Distribution of MPG by Number of Cylinders"
  ) +
  theme_minimal()

hist_plot_b


## For problems 3 and 4, we will work with the ChickWeight data.
chickdata <- as.data.frame(ChickWeight) 
View(chickdata)
chick1 <- chickdata |> filter(Chick==1) ## getting info for only Chicken #1, to
                                        ## use in Problem 3

## Problem 3 (15 points) Line chart
## Using the chickdata df, plot a line chart that displays the relationship 
## between time and weight for Chicken #1. Add appropriate labels. Assign your 
## plot an object name, and use this object name to save your plot to a PNG 
## file. There is no need to submit the PNG file for this assignment, but be 
## sure you know where it is saved to on your computer!
## Problem 3 (15 points) Line chart

line_chart <- ggplot(chick1, aes(x = Time, y = weight)) +
  geom_line() +
  geom_point() +
  labs(
    x = "Time (Days)",
    y = "Weight (grams)",
    title = "Growth of Chicken #1 Over Time"
  )

line_chart

## Save the plot as a PNG file
ggsave(
  filename = "chicken1_growth.png",
  plot = line_chart,
  width = 6,
  height = 4,
  dpi = 300
)



## Problem 4 (15 points) Scatter plot
## Using the chickdata df, plot a scatter plot below where the x-axis is the
## time variable, and the y-axis is the chicken's weight. Set your color = Diet,
## this will color your points based on which diet the chicken was fed. Add
## appropriate labels. In your opinion, based on your graph, is there a 
## difference between the diets and the chicken's weight?

chick_scatter <- ggplot(chickdata, aes(x = Time, y = weight, color = Diet)) +
  geom_point(alpha = 0.7) +
  labs(
    x = "Time (days)",
    y = "Weight (grams)",
    title = "Chicken Weight Over Time by Diet"
  ) +
  theme_minimal()

chick_scatter

##Based on the scatter plot, Diet 3 and Diet 4 show higher weights over time than Diet 1.

