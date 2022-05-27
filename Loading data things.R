library(tidyverse)

#read in downloaded csv from computer.. assumes location is your project folder
train <- read_csv("train.csv")
#click on the file and click import. it will show you the commands it will use

# load a table from the internet when the data is embeded in the website
#install.packages("rvest")
library(rvest)


#### Underscore csv is a tibble and dot csv is a data set




url = "https://www.boxofficemojo.com/year/"
#3 specific commands to turn in data from a website into a dataset 
#this only works because only one table on sreen and table was nice
url%>%
  read_html() %>%# grabs the entire source code
  html_node("table")%>% # this gets the table node
  html_table() # formats nonsense into a table

# Multiple tables
sports_data <- "https://www.sportsmediawatch.com/college-football-tv-ratings/2/"
sports_data%>%
  read_html() %>%# grabs the entire source code
  html_nodes("table")%>% # this gets the table nodes (change to s to grab all tables)
  html_table()


# this grabs just the last table from the webpage
sports_data <- "https://www.sportsmediawatch.com/college-football-tv-ratings/2/"
sports_data%>%
  read_html() %>%
  html_nodes("table")%>% 
  .[[17]] %>% #pick the 17th table
  html_table()



#### SECOND DAY CORRECTION DAY
read.csv("path to folder")

# Export from excel... (1) save 
#install.packages("readxl")
library(readxl)
# read in first sheet
MLBrecordatbreak <- read_excel("MLBrecordatbreak.xlsx")
View(MLBrecordatbreak)

# read in any other sheet
MLB2 <- read_excel("MLBrecordatbreak.xlsx",
                               sheet = 2) 
MLB3 <- read_excel("MLBrecordatbreak.xlsx",
                   sheet = "After2011")
MLB2
MLB3

# Reading in SAS files, xpt file
library(haven)

# good idea to name file to something else
filename <- "DR1IFF_I.XPT"
food = read_xpt(filename)
food

#SPSS Social sciences file, save in sav,
#need haven library
filename = "TennisDeIdentifiedData.sav"
read_sav(filename)

### Jas-on only data file you need two libraries
#install.packages("rjson")
library(rjson)

filename = "jsoneasy.json"
jlist = fromJSON(file = filename)
jlist
jdata = as_tibble(jlist)
jdata

#### Third Day
library(tidyverse)
#install.packages("tidyjson")
library(rjson)
library(tidyjson)

# case 1
# data is stored as variables with their values
# Easy mode
Case1 <- "jsoneasy.json"
jlist = fromJSON(file = Case1)
jlist %>%
  as_tibble() %>%
  View()

# Case 2
# data is organized by observation instead of by variable
# Moderate Mode

# this doesnt work
Case2 <- "json_moderate.json"
jlist2 = fromJSON(file = Case2)
jlist %>%
  as_tibble() %>%
  View()
## To make it work use a spread_all() from tidyjson
jlist2 %>%
  spread_all( )%>%
  as_tibble() %>%
  View()

# Case 3
# Also split up by observation but some variables are nested.
#you will see sub variable with a dot
# Boss Mode
Case3 <- "json100-2.json"
jlist3 = fromJSON(file = Case3)
jlist3%>%
  spread_all()%>%
  as_tibble()%>%
  View()

# Case 4
#
# Boss mode +1



