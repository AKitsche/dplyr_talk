#date: 14.11.2017
#author: Andreas Kitsche
#title: Introduction to data manipulation in R
#subtitle: basic dplyr verbs

########################################################
#######   loading required packages            #########
########################################################
library(tidyverse)
library(nycflights13)

########################################################
#######                  tibbles               #########
########################################################
#Tibbles are data frames, but they tweak some older behaviours to make life a little easier.
#tibble() vs. data.frame()
test_tibble <- tibble(x = 1:5, 
                      y = 1, 
                      z = letters[1:5])
str(test_tibble)
class(test_tibble)

test_data_frame <- data.frame(x = 1:5, 
                              y = 1, 
                              z = letters[1:5])
str(test_data_frame)
class(test_data_frame)

str(nycflights13::airlines)
str(datasets::iris)

########################################################
#######         selecting columns              #########
########################################################
#Select a subset of the columns of a data frame by names:
weather[,c("origin", "temp", "precip")]
select(weather, origin, temp, precip)
select(weather, origin:temp)
select(weather, -(year:hour))

starwars[, c("name", "species", "homeworld")]
select(starwars, name, species, homeworld)

starwars[, c(1, 10, 9)]
select(starwars, c(1, 10, 9))
select(starwars, c(1:9))
starwars[, -c(1:5)]
select(starwars, -c(1:5))

########################################################
#######           filter rows                  #########
########################################################  
#select a subset of the rows of a data frame
weather[weather$origin=="EWR" | weather$month==1,]

subset(weather, origin=="EWR" | origin==1)
subset(weather, origin=="EWR" & month==1)

filter(weather, origin=="EWR" | origin=="JFK")
filter(weather, origin=="EWR" & month==1)

?dplyr::filter
# Multiple arguments are equivalent to and
filter(starwars, homeworld == "Tatooine" & species == "Human")
filter(starwars, homeworld == "Tatooine", species == "Human")
filter(starwars, height >= 200)

#Select a subset of the rows of a data frame by numbers
weather[1:10,]
slice(weather, 1:10)

starwars$homeworld %in% c("Naboo", "Kamino")
which(starwars$homeworld %in% c("Naboo", "Kamino"))
slice(starwars, which(starwars$homeworld %in% c("Naboo", "Kamino")))
#equivalent to:
filter(starwars, homeworld == "Naboo" | homeworld == "Kamino")
filter(starwars, homeworld %in% c("Naboo", "Kamino"))

########################################################
#######           arrange rows                 #########
######################################################## 
#Arrange rows by variables (reorder the rows)
?order
order(weather$temp, weather$precip)
weather[order(weather$temp, weather$precip),]

arrange(weather, temp, precip)
arrange(weather, desc(temp))#Use desc() to order a column in descending order

arrange(starwars, species, desc(height))

########################################################
#######          mutate columns                #########
########################################################
#Add new columns that are functions of existing columns.
weather$precip_to_temp <- weather$precip/weather$temp
base::transform(weather, precip_to_temp = precip/temp)

mutate(weather, precip_to_temp = precip/temp)

mutate(weather, 
       precip_to_temp = precip/temp,
       precip_to_temp_10 = precip_to_temp*10)

#Note: If you only want to keep the new variables, use transmute()
transmute(weather, 
          precip_to_temp = precip/temp,
          precip_to_temp_10 = precip_to_temp*10)

mutate(starwars, bmi = mass/(height^2))
mutate(starwars, homeworld_species = paste(homeworld, species, sep = "_"))

########################################################
#######       summarising data sets            #########
########################################################
summarise(weather, mean_temp = mean(temp, na.rm=TRUE))
summarise(weather, mean_temp = mean(temp, na.rm=TRUE),
          sd_temp   = sd(temp),
          median_sd = median(temp))

#With data frames, you can create and immediately use summaries
summarise(weather, mean_temp = mean(temp, na.rm=TRUE),
          sd_temp = sd(temp),
          mean_sd_temp = mean_temp/sd_temp)

aggregate(weather$temp, by = list(origin = weather$origin), FUN = mean)
aggregate(temp ~ origin, data = weather, FUN = mean)#formula notation

#use group_by() in combination with summarise
dplyr::summarise(group_by(weather, origin), max(temp))
dplyr::summarise(group_by(weather, origin), length(temp))
dplyr::summarise(group_by(weather, origin), count_origin=n())
dplyr::summarise(group_by(weather, origin, year), count_origin_year=n())

dplyr::summarise(group_by(starwars, species), n())
dplyr::summarise(group_by(starwars, homeworld, species), n())

########################################################
#######    Commonalities of dplyr verbs        #########
########################################################
#The first argument is a data frame
#The subsequent arguments describe what to do with it, and you can refer to columns in the data frame directly without using $
#The result is a new data frame