#date: 14.11.2017
#author: Andreas Kitsche
#title: Introduction to data manipulation in R
#subtitle: Join two data sets together

########################################################
#######   loading required packages            #########
########################################################
library(tidyverse)
library(nycflights13)

########################################################
#######   Join two data sets together          #########
########################################################
# Drop unimportant variables so it's easier to understand the join results.
flights2 <- flights %>% select(year:day, hour, origin, dest, carrier)
flights2 %>% 
  merge(airlines) %>%
  head(2)

flights2 %>% 
  left_join(airlines) %>%
  head(2)

########################################################
#########      Types of join                   #########
########################################################
df_1 <- data_frame(x = c(1, 2), y = 2:1)
df_1
df_2 <- data_frame(x = c(1, 3), a = 10, b = "a")
df_2

#inner_join(x, y) only includes observations that match in both x and y.
df_1 %>% inner_join(df_2)
#left_join(x, y) includes all observations in x, 
#regardless of whether they match or not. 
#This is the most commonly used join because it ensures that you don't lose observations from your primary table.
df_1 %>% left_join(df_2)
#right_join(x, y) includes all observations in y. 
#It's equivalent to left_join(y, x), but the columns will be ordered differently.
df_1 %>% right_join(df_2)
df_2 %>% left_join(df_1)
#full_join() includes all observations from x and y.
df_1 %>% full_join(df_2)