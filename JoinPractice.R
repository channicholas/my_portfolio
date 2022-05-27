library(tidyverse)
library(rvest)


# read in covid.csv file
landsize_url = "https://statesymbolsusa.org/symbol-official-item/national-us/uncategorized/states-size"
income_url = "https://en.wikipedia.org/wiki/List_of_U.S._states_and_territories_by_income"



library(readr)
# Task 1:
covid <- read_csv("DATA STUFF/covid.csv")
landSize = landsize_url%>%
  read_html() %>%
  html_node("table")%>%
  html_table(header = TRUE)%>%
  select(-1)%>%
  rename(Land = "Square Miles (Land Area)")

#Still need to make land a numeric value
landSize %>%
  mutate(Land = as.numeric(gsub(",", "", Land)))

### why does it make a column only saying 2018
income_data = income_url %>%
  read_html() %>%
  html_nodes("table") %>%
  .[[4]] %>%
  html_table() %>%
  rename(State = "State or territory", 
         Income = "Medianhouseholdincome")%>% # rename so shares the sam ename as the other data sets
  mutate(Income = as.numeric(gsub("[$,]", "", Income)))
income_data
# Read in all three data sets. Find the table
# from the income data set with median household income

# Task 2
income_data$State <- income_data$`State or territory`
covidLand = landSize %>%
  left_join(covid, by = c("State"))

# Create a dataset that can be used to explore 
# landsize and covid numbers for 50 states
# why can't simply adding the columns with a 
# bind_cols command work?
# Which joins will and will not work?


# Task 3
covidLand %>%
  mutate(Land = as.numeric(gsub(",","", Land)))%>%
  mutate(Density = Population / Land)%>%
  ggplot() +
  geom_point(mapping = aes(x = Density, y = CasesPerMil))
covidLand
# Plot covid numbers against
# Population Density (Population/Landsize)



# Task 4
# Create a data set that can explore covid 
# numbers with income AND landsize for 50 states


covidAll = covidLand %>%
  inner_join(income_data,by="State")%>%
ggplot(covidAll) +
  geom_point(mapping = aes(x = Density, y = CasesPerMil))


# Task 5
#subs out dollar signs and commas for nothing
as.numeric(gsub("[,$]","","45,123"))
# Plot covid numbers against median 
# household income



### Strings
my_string <- "this is a string"
class(my_string)




