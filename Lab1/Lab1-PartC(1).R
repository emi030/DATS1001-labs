## Lab1-PartC.R
## DATS1001 - Data Science for All
## STUDENT NAME: 
## DUE: January 23rd 11:59 PM

## Below we have defined a collection or a vector of numbers. Do not change this
## line!
numberVector <- c(5, 10, 3, 7, 1, 5, 8, 9, 12, 6, 2)

## Problem 1 (3 points) Let's start by calculating some values using our 
## vector. Calculate the mean() of the vector below. Print this 
## value to the console. Your final answer should be about 6.18.
mean(numberVector)

## Problem 2 (3 points) Calculate the length() of the vector below. Print this 
## value to the console. You final answer should be 11.
length(numberVector)

## Problem 3 (4 points) Next let's try indexing our vector. Use indexing to 
## print the 3rd through the 6th values in the vector to the console. Your 
## final answer should be 3, 7, 1, 5.
numberVector[3:6]

## Problem 4 (4 points) Use logical based indexing to print only the items in 
## the vector that are greater than or equal to 10. Print the resulting 
## values to the console. Your final answer should be 10 and 12.

numberVector[numberVector >= 10]

## Problem 5 (5 points) Use the sample() function to randomly sample 2 items 
## from our collection. The documentation for sample() is available at this 
## link: 
## https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/sample
## Since this function is random, you will get a different result every time!

sample(numberVector, 11, replace = FALSE, prob = NULL)

## Problem 6 (5 points) Multiply the elements of our collection by the scalar 7. 
## Then, sum() these new values and save it as a new variable. Print this 
## variable to the console. Your final answer should be 476.

sum(numberVector*7)

## Problem 7 (6 points) Take the exp() of the vector, then take the log(). Does
## the following equation hold true? Be sure to answer yes or no (worth 1 point)
##                      b
##              log ( e   ) = b

log(exp(numberVector))
#Yes
## REMEMBER TO SAVE YOUR WORK


