library(nycflights13)

newflights <- mutate(flights, something = year+1)
flights

#orders on departure time 
arrange(flights,dep_time)

#orders the data based on departure time, descending
arrange(flights, desc(dep_time))

# orders on departure time but if there is a tie then it orders in scheduled time
arrange(flights, desc(dep_time), sched_dep_time)

#creates a new data set based on a statistical sumamry of the old data set
#this one runs means
summarize(flights, meanday = mean(day), meanmonth = mean(month))

# This is called aggregating
by_day <- group_by(flights, day)
summarize(by_day, meanmonth= mean(month))

## mean depature time based on day and omitting "NA" or missing data
summarize(by_day, meandeps = mean(dep_time, na.rm = TRUE))

#creates a variable named count. 
by_dest = group_by(flights,dest)
by_dest
delays = summarize(by_dest, 
                   count = n(),
                   dist = mean(distance, na.rm = TRUE,
                   delay = mean(arr_delay, na.rm = TRUE)))
delays = filter(delays, count > 20, dest!="HNL")

ggplot(data = delays, mapping = aes(x=dist, y=delay))+
  geom_point(mapping = aes(size = count), alpha = 1/3)+
  geom_smooth(se=FALSE)

#piping goes in order and 
flights %>% select(year,dest) %>% filter(dest == "SLC")

flights %>%
  group_by(dest) %>% 
  summarize(count = n(),
            dist = mean(distance, na.rm = TRUE),
            delay = mean(arr_delay, na.rm = TRUE)) %>%
  filter(count > 20, dest!="HNL" %>%
           ggplot( mapping = aes(x=dist, y=delay))+
           geom_point(mapping = aes(size = count), alpha = 1/3)+
           geom_smooth(se=FALSE))
           

delays