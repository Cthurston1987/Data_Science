## Load packages needed to wrangle data.

library(tidyr)
library(dplyr)

## Load file into local data frame and get rid of black spaces removing last row
tn<- read.csv("titanic_original.csv", na.strings = c("", "NA"))
tn <- tn[1:1309,]

## The embarked column has one missing value,  Find the missing value and replace it with S.
which(is.na(tn$embarked))  ## find value came up with 3 however only 2 are actual passengers, an't discern by family name or ticket number where they might have gotten on

tn$embarked[which(is.na(tn$embarked))] <- "S"


## Calculate the mean of the Age column and use that value to populate the missing values
tn$age[which(is.na(tn$age))] <- mean(tn$age, na.rm = T)

##Think about other ways you could have populated the missing values in the age column. Why would you pick any of those over the mean (or not)?
median(tn$age)

## There are a lot of missing values in the boat column. Fill these empty slots with a dummy value e.g. NA


## Does it make sense to fill missing cabin numbers with a value?


## What does a missing value here mean?


## Create a new column has_cabin_number which has 1 if there is a cabin number, and 0 otherwise


##  Submit the project on Github Include your code, the original data as a CSV file titanic_original.csv, and the cleaned up data as a CSV file called titanic_clean.csv