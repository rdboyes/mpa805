library(readr)
library(summarytools)
library(tidyverse)

#import the ames housing dataset

housing <- read_csv("~/Downloads/ames.csv")

#initialize a variable with all zeros

housing$include <- 0

#assign a 1 to 20% of those at random

for(i in 1:2930){
  housing$include[i] <- rbinom(1,1,0.20)
}

#check to make sure that worked

freq(housing$include)

#split zeros and ones 

train <- housing[housing$include == 0,]
test <- housing[housing$include == 1,]

#new ID variable

train$Id <- seq.int(nrow(train))
test$Id <- seq.int(nrow(test))

#remove train/test marker

train <- train %>% select(-include, -Order, -PID)
test <- test %>% select(-include, -Order, -PID)

#save test set as 'answers'

answers <- test %>% select(Id,SalePrice)

write.csv(answers,file="answers.csv")

#drop answers from test set

test <- test %>% select(-SalePrice)
