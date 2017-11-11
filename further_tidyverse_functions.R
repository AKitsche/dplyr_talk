#date: 14.11.2017
#author: Andreas Kitsche
#title: Introduction to data manipulation in R
#subtitle: Further useful functions in the tidyverse

########################################################
#######   loading required packages            #########
########################################################
library(tidyverse)
library(nycflights13)

########################################################
#######   Get an overview of your data         #########
########################################################
utils::str(iris)#Compactly Display the Structure of an Arbitrary R Object
tibble::glimpse(iris)#This makes it possible to see every column in a data frame.

utils::str(starwars)
tibble::glimpse(starwars)

########################################################
#######  Combine multiple data frames          #########
########################################################
test_data_1 <- tibble(x = 1:5, 
                      y = 1, 
                      z = letters[1:5])

test_data_2 <- tibble(x = 1:8, 
                      y = 1, 
                      r = letters[1:8])
                
base::rbind(test_data_1, test_data_2)
dplyr::bind_rows(test_data_1, test_data_2)

########################################################
#######  Rename variable names                 #########
########################################################
rename(iris, 
       petal_length = Petal.Length,
       sepal_length = Sepal.Length,
       petal_width = Petal.Width,
       sepal_width = Sepal.Width)

rename(starwars, bla_bla_bla = name)

########################################################
#######   Helper functions for select()        #########
########################################################   
select(iris, starts_with("Petal")) %>% head(2)
select(iris, ends_with("Width")) %>% head(2)

# Move Species variable to the front
select(iris, Species, everything()) %>% head(2)


########################################################
#####   Operate on a selection of variables       ######
######################################################## 
iris %>%
  group_by(Species) %>%
  summarise_all(mean)

select_all(starwars, .funs = toupper)#all column names toupper
select_if(starwars,  .predicate = is.double)#does not select variable height, because its integer

starwars %>%
  mutate_if(is.integer, as.double) %>%
  group_by(species) %>%
  select_if(is.double) %>%
  summarise_all(funs(med = median,
                     mean = mean)) %>%
  ungroup()
