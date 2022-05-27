# combining DATA SETS
# https://thomasadventure.blog/posts/r-merging-datasets/
# Joins, Merges, Combines
library(tidyverse)


# Datasets for Stat 250 join lecture

#BS Statistics Degree Data: https://ww2.amstat.org/misc/StatsBachelors2003-MostRecent.pdf
#MS Statistics Degree Data: https://ww2.amstat.org/misc/StatsMasters2003-MostRecent.pdf

stat_programs <- read_csv("
School,   Year,  BS_Stat
Berkeley, 2013,     143
Berkeley, 2014,     160
Berkeley, 2015,     215
Berkeley, 2016,     174
Berkeley, 2017,     215
Berkeley, 2018,     226
BYU,      2013,      35
BYU,      2014,      42
BYU,      2015,      57
BYU,      2016,      69
BYU,      2017,     101
BYU,      2018,     136
Duke,     2013,       8
Duke,     2014,      14
Duke,     2015,      23
Duke,     2016,      33
Duke,     2017,      40
Duke,     2018,      33
Harvard,  2013,      23
Harvard,  2014,      36
Harvard,  2015,      43
Harvard,  2016,      63
Harvard,  2017,      95
Harvard,  2018,     100
")


#https://www.chronicle.com/interactives/tuition-and-fees
#in-state tuition for Berkeley

school_tuition <- read_csv("
School,   Year,  Tuition
Berkeley, 2013,  12864
Berkeley, 2014,  12972
Berkeley, 2015,  13431
Berkeley, 2016,  13485
Berkeley, 2017,  13928
Berkeley, 2018,  14184
BYU,      2013,   4850
BYU,      2014,   5000
BYU,      2015,   5150
BYU,      2016,   5300
BYU,      2017,   5460
BYU,      2018,   5620
Duke,     2013,  45376
Duke,     2014,  47243
Duke,     2015,  49241
Duke,     2016,  51265
Duke,     2017,  53500
Duke,     2018,  55695
Harvard,  2013,  42292
Harvard,  2014,  43938
Harvard,  2015,  45278
Harvard,  2016,  47074
Harvard,  2017,  48859
Harvard,  2018,  50420
")


# Nobel Prizes 
#  missing is zero

school_nobel <- read_csv("
School, Year, Nobel
Harvard,  2013, 5
Harvard,  2014, 1
Harvard,  2016, 3
Harvard,  2018, 1
Harvard,  2019, 4
Berkeley, 2013, 1
Berkeley, 2014, 1
Berkeley, 2015, 2
Berkeley, 2016, 1
Berkeley, 2017, 3
Berkeley, 2018, 2
Duke,     2015, 1
Duke,     2018, 1
Duke,     2019, 1
")


# put something in qoutes to make sure it is a special characteror do double qoutes and put the special thing in singl qoutes
stat_faculty <- read_csv('
School,   Year, Faculty
"Berkeley", 2018,   31
BYU,      2018,   22
Duke,     2018,   27
Harvard,  2018,   18
')

# Adding a backslash means not important.
stat_faculty <- read_csv("
School,   Year, Faculty
\"Berkeley\", 2018,   31
BYU,      2018,   22
Duke,     2018,   27
Harvard,  2018,   18
")



stat_programs %>%
  bind_cols(school_tuition)

# Maybe a better way to do this...
# https://thomasadventure.blog/posts/r-merging-datasets/
# Left join left side keeps everything and on the right, we will add it as long as the left set has it. But if it doesn't dump it
# 
# Right join --> same thing but now the right data set is important... so you dump anything excess form the left set
#
#Inner join --> it will dump anything not contained in both data sets. 
#
# Full join --> Everybody is welcome! anybody and everybody joins the data set.

# joins
stat_programs %>%
  left_join(school_tuition, by = c("School", "Year" ))

stat_programs %>%
  right_join(school_tuition, by = c("School", "Year" ))

stat_programs %>%
  inner_join(school_tuition, by = c("School", "Year" ))

stat_programs %>%
  full_join(school_tuition, by = c("School", "Year" ))

# When identical keys, type of join doesn't matter ^^^^^ Below this one is same but different order
school_tuition %>%
  left_join(stat_programs, by = c("School", "Year" ))

# This doesn't change the order of the data frame
stat_programs %>%
  left_join(school_tuition, by = c("Year", "School" ))


# Try out the Joins ## you get Na's when the data frame joining the other doesn't have that row and column.
# has 
stat_programs %>%
  left_join(school_nobel, by = c("School", "Year"))

# only 14 rows because nobel only have 14 rows
stat_programs%>%
  right_join(school_nobel, by = c("School", "Year"))

# never get NA's with inner "AND" (240)
stat_programs %>%
  inner_join(school_nobel, by = c("School", "Year"))
  
# Get the most NA's throw in an NA if it is missed in either data set
stat_programs %>%
  full_join(school_nobel, by = c("School", "Year"))

# Puts a 0 to all NA's
stat_programs %>%
  left_join(school_nobel, by = c("School", "Year")) %>%
  mutate(Nobel = ifelse(is.na(Nobel),0,Nobel)) %>%
  View()


stat_programs%>%
  left_join(stat_faculty, by = c("School", "Year"))

#make staff faculty show for every year by implying faculty is the same, and 
#then select so only one year is showing and changing the name of year.x
stat_programs%>%
  left_join(stat_faculty, by = "School")%>%
  select(-Year.y) %>%
  rename(Year = Year.x)

# Make a big giant data frame... Putting it all together
stat_programs %>%
  left_join(school_tuition, by = c("School", "Year" ))%>%
  left_join(school_nobel, by = c("School", "Year")) %>%
  mutate(Nobel = ifelse(is.na(Nobel),0,Nobel)) %>%
  left_join(stat_faculty, by = "School")%>%
  select(-Year.y) %>%
  rename(Year = Year.x)







