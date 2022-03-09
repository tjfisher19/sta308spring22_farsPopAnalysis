library(dplyr)

## Load data from Monday
load("dataAfterDay01.RData")

glimpse(county_level_data)
glimpse(OhioCountyPop)

## Turn "ADAMS (1)" into "Adams"

## We will use stringr functions to do it
library(stringr) ## loads with tidyverse

## Long-winded solution
county_level_data2 <- county_level_data %>%
  mutate(County2 = str_remove_all(County, "[:digit:]"),  # removes all digits
         County3 = str_remove_all(County2, "[:punct:]"), # removes all punctuation characters
         County4 = str_trim(County3),      # removes spacing at beginning and end of string
         County5 = str_to_title(County4))  # put in title text

View(county_level_data2)

## Now I can merge the two!!!!!!

## An alternative to the above....
##   remove that space at the end with str_sub
county_level_data3 <- county_level_data %>%
  mutate(County2 = str_remove_all(County, "[:digit:]"),  # removes all digits
         County3 = str_remove_all(County2, "[:punct:]"), # removes all punctuation characters
         Len = str_length(County3),
         County4 = str_sub(County3, start=1, end=Len - 1),
         County5 = str_to_title(County4))
View(county_level_data3)

## I need to use str_sub on Midterm

## Let's remove all those extra county variables 
##   that we created in county_level_data2
county_level_data4 <- county_level_data2 %>%
  select(County5, Fatalities)
glimpse(county_level_data4)

## Now I can merge!
glimpse(OhioCountyPop)

## Merge when "County" == "County5"
ohioCountyFatalPop <- merge(OhioCountyPop,
                            county_level_data4,
                            by.x="County",
                            by.y="County5")
glimpse(ohioCountyFatalPop)

plot(ohioCountyFatalPop$Population, ohioCountyFatalPop$Fatalities)

## Put on the same scale, using a rate
ohioCountyFatalPop <- ohioCountyFatalPop %>%
  mutate(Fatality_rate = Fatalities/Population*10000)

## Highest 10 counties (by rate)
ohioCountyFatalPop %>%
  arrange(desc(Fatality_rate)) %>%
  slice(1:10)

## Lowest 10 counties (by rate)
ohioCountyFatalPop %>%
  arrange(Fatality_rate) %>%
  slice(1:10)

## Let's save our processed data!
save(ohioCountyFatalPop,
     file="countyFatalityRates.RData")
