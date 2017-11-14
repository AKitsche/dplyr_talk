#date: 14.11.2017
#author: Andreas Kitsche
#title: Introduction to data manipulation in R
#subtitle: reshaping data

########################################################
#######   loading required packages            #########
########################################################
library(tidyverse)
library(nycflights13)

########################################################
#### gather data: makes "wide" data longer       #######
########################################################
mini_iris <-
  iris %>%
  group_by(Species) %>%
  slice(1)
mini_iris %>% gather(key = flower_att, value = measurement, -Species)

########################################################
#### spread data: making "long" data wider       #######
########################################################
mini_iris %>% 
  gather(key = flower_att, value = measurement, -Species) %>%
  spread(key = flower_att, value = measurement)



iris %>% 
  gather(key = flower_att, value = measurement, -Species) %>%
  separate(data = ., col = flower_att, into = c("flower_part", "measure_type")) %>%
  ggplot(aes(x = Species, y =  measurement)) +
  geom_boxplot(aes(fill = flower_part)) +
  facet_grid( ~ measure_type)
