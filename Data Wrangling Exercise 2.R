## Load packages needed to wrangle data.

library(tidyr)
library(dplyr)

## Load file into local data frame
tn<- read.csv("titanic_original.csv")

## The embarked column has one missing value,  Find the missing value and replace it with S.


## Calculate the mean of the Age column and use that value to populate the missing values


##Think about other ways you could have populated the missing values in the age column. Why would you pick any of those over the mean (or not)?


## There are a lot of missing values in the boat column. Fill these empty slots with a dummy value e.g. NA


## Does it make sense to fill missing cabin numbers with a value?


##