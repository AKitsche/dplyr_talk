#date: 14.11.2017
#author: Andreas Kitsche
#title: Introduction to data manipulation in R
#subtitle: the pipe operator

########################################################
#######   loading required packages            #########
########################################################
library(tidyverse)
library(nycflights13)

########################################################
#### Usual way to perform multiple operations    #######
########################################################
#Save objects :
Data_1 <- filter(weather, origin=="EWR", year==2013, between(precip, 0.05, Inf))
Data_2 <- select(Data_1,  origin:temp)
Data_3 <- mutate(Data_2, temp_square = temp^2)
Data_4 <- group_by(Data_3, origin, month)
Data_5 <- summarise(Data_4, min(temp_square))
Data_5

#Nesting operations: Hard to read Code! (Jumping around the code):
summarise(
  group_by(
    mutate(
      select(
        filter(weather, origin=="EWR", year==2013, between(precip, 0.05, Inf))
        , origin:temp)
      , temp_square = temp^2)
    ,origin, month)
  , min(temp_square))

########################################################
######         Chaining or Pipelining            #######
########################################################
weather %>% 
  filter(origin=="EWR", year==2013, between(precip, 0.05, Inf)) %>%
  select(origin:temp) %>%
  mutate(temp_square = temp^2) %>%
  group_by(origin, month) %>%
  summarise(min(temp_square)) %>%
  ungroup()

starwars %>%
  filter(species == "Human") %>%
  group_by(homeworld) %>%
  summarise(N_human = n()) %>%
  ungroup()
  