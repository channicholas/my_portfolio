library(nycflights13)

#makes a tibble
my_tibble <- tibble(x = 1:4, y = c("a", "b", "cat", "dog"))

my_tibble%>% select(x)

#use specific variables
my_tibble$x
my_tibble[["x"]]

# Row (2), Column (1)
my_tibble[2,1]

flights

# Print off Arrival time
flights$arr_time
flights[,7]

# Makes A Data Frame
my_dat <- data.frame(x = 1:4, y = c("a", "b", "cat", "dog"))
fl_dat <- as.data.frame(flights)
head(fl_dat)
# creating data frames to tibbles and vis versa
tibble(my_dat)
as_tibble(my_dat)
as.data.frame(my_tibble)

# VIEW A TIBBLE DIFFERENTLY prints 15 rows and shows all variables
flights %>%
  print(n = 15, with = Inf)

flights %>% View()

### http://grimshawville.byu.edu/bestpicture.txt
### https://sites.ualberta.ca/~kashlak/data/oscDataTable.txt

# reads in the table as a data frame
movies <- read.csv("http://grimshawville.byu.edu/bestpicture.txt", header = FALSE)

head(movies)
names(movies) = c("Movie", "Win", "RT", "Rating")

# reads in the table as a tibble
read_csv("http://grimshawville.byu.edu/bestpicture.txt",
         col_names= c("Movie", "Win", "RT", "Rating") )

#skips 14 rows
read.csv("https://sites.ualberta.ca/~kashlak/data/oscDataTable.txt", skip = 14, sep = "")


