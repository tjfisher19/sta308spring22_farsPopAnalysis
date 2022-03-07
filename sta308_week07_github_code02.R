#######################################
## 
## sta308_week07_github_code02.R
##
## Bailer/Fisher
##
## Important!!!!
##    - Save this .R file into the folder with your 
##      Day 15 Project, likely called 
##      sta308_day17_assignment-userID
##    - Make sure you have run the code in the 
##      data processing file sta308_week07_github_code01.R
##      You should have the resulting data.frame in your
##      environment to complete this part of the assignment.
##
## This R code is provided to streamline
##   the discussion for day 18 of STA 308.
##
## The code provided below should be familiar...
##   We read in county-level census data
##   and extract the population of each county of Ohio
##
## At the end of this file, write code that merges
##   the county-level vehicle fatality data with the
##   population data included here. Explore the
##   relationship between population and fatalities, adjust
##   as appropriate and explore which counties seem most
##   dangerous.


#### Fetch the US Census data
OhioPop <- 
  read_csv("https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/counties/asrh/cc-est2019-agesex-39.csv") 

##################################
## Extract the most recent year with filter (12==2019)
## Get the county names and drop the word " County"
## Select the county names and corresponding populations
##
OhioCountyPop <- OhioPop %>% 
  filter(YEAR == 12) %>% 
  mutate(County = str_remove(CTYNAME, " County") ) %>% 
  select(County, Population=POPESTIMATE) 
glimpse(OhioCountyPop)

save(county_level_data,
     OhioCountyPop,
     file="dataAfterDay01.RData")

#####################
## Below, edit the character string from the
##   county-level fatality data and merge
##   it will the population data from above.


