######################################
## 
##  sta308_week07_github_code01.R
##
##  This code is a streamlined version of
##    the results from Friday, March 4, 2022
##  We will start off class by running this code.
##
## 1. demonstrates functionality of the fromJSON()
##    function and demonstrates the NHTSA FARS API
## 2. Provides a function that will fetch the crash
##    data for a given county in Ohio (specified by
##    a FIPS code number: 1, 3, 5,..., 173, 175
##    see: https://en.wikipedia.org/wiki/List_of_counties_in_Ohio
##
## Task: Your task is to take this output from the API
##       and build a data.frame where each row
##       corresponds to a County in Ohio and the
##       recorded number of fatalities in 2018-2019.
##       Determine which 6 counties have the highest and 
##         lowest number of fatalities.
##

## Load necessary libraries

library(jsonlite)
library(tidyverse)

#################################
## get_county_json(county=1)
##
## This function takes the provided 'county' number
##   parameter and appends it to the website/API
##   call. The result of the API call is then output.
## We use this function so we can lapply() over
##   all valid county FIPS codes.
get_county_json <- function(county=1) {
  site <- paste0("https://crashviewer.nhtsa.dot.gov/CrashAPI/crashes/GetCrashesByLocation?fromCaseYear=2018&toCaseYear=2019&state=39&county=", 
                 county, 
                 "&format=json")
  fromJSON(site)
}

all_county_list <- lapply(seq(1,175,2), get_county_json)

## Last week, we first solved the mini problem of Adams
##   county, then we generalized with the following

get_county_fatalities <- function(x) {
  x$Results[[1]] %>%
    summarize(Fatalities = sum(as.numeric(FATALS)),
              County = first(COUNTYNAME))
}

county_level_data_list <- lapply(all_county_list, get_county_fatalities)

county_level_data <- bind_rows(county_level_data_list)
glimpse(county_level_data)

## For each of the 88 counties we have the number of 
##  fatalities due to automobile crashed in 2018-2019

