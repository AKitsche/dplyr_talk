#date: 14.11.2017
#author: Andreas Kitsche
#title: Introduction to data manipulation in R
#subtitle: reshaping data

########################################################
#######   loading required packages            #########
########################################################
library(tidyverse)
library(broom)
########################################################
#### gather data: makes "wide" data longer       #######
########################################################
iris %>% gather(key = flower_att, value = measurement, -Species)

########################################################
#### spread data: making "long" data wider       #######
########################################################
iris %>% 
  gather(key = flower_att, value = measurement, -Species) %>%
  spread(key = flower_att, value = measurement)

########################################################
#### splotting the data in one step              #######
########################################################
iris %>% 
  gather(key = flower_att, value = measurement, -Species) %>%
  separate(data = ., col = flower_att, into = c("flower_part", "measure_type")) %>%
  ggplot(aes(x = Species, y =  measurement)) +
  geom_boxplot(aes(fill = flower_part)) +
  facet_grid( ~ measure_type)

########################################################
#### tidy a model using broom package            #######
########################################################
iris_lm <- iris %>% 
  gather(key = flower_att, value = measurement, -Species) %>%
  separate(data = ., col = flower_att, into = c("flower_part", "measure_type")) %>%
  lm(measurement ~ Species, data = .) 

#result of a test into a summary data.frame
iris_lm %>% broom::tidy()
#Construct a single row summary of the model
iris_lm %>% broom::glance()
#Augment - add columns to the original dataset such as predictions, residuals
iris_lm %>% broom::augment()
