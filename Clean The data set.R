#CLEAN THIS DATA
library(tidyverse)

# remove missing data
###remove NA's
### missing data flags that aren't NA's

#Variable names

#Data Types
## Character to numeric
##string things

#Dates

# merging




fashion <- read.csv("fashion-1.csv", header = TRUE)
fashion%>%
  View()
class(fashion[["Price (INR)"]])

#Fix Gender
fashion$Gender[fashion$Gender == "women"] <- "Women"
fashion <- fashion%>%
  mutate(Gender = str_to_title(Gender)) #makes first letter upper case

#Fix Product Brand (NA's)
fashion <- fashion%>%
  filter(!is.na(ProductBrand)) # this gets rid of NA's from one specific variable
fashion <- na.omit(fashion)# both of these filter Na's this one does all NA's

sum(is.na(fashion$ProductBrand)) #checks how many NA's

#Fix name of PRICE (INR)
names(fashion)[5] <- "Price" # this changes the name of the 5th element in fashion
names(fashion)

# change price to numeric
str_replace_all(fashion$Price, " dollars", "")

fashion <- fashion%>%
  mutate(Price = as.numeric(str_replace_all(Price, " dollars",""))) #can do this both ways

fashion%>%
  group_by(Gender)%>%
  summarize(meanPrice = mean(Price))

#EXTRA
str_split(fashion$Price, " ", simplify = TRUE) #another way to split the price by a space












