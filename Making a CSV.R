
#This is my tibble
BYUFootball = tibble(
  "Games" = 1:7,
  "Wins" = c(1,1,1,1,1,1,0),
  "QB" = c("Hall", "Hall", "Hall", "Connover", "Romney", "Hall","Hall")
)

#Creates a csv file
write_csv(BYUFootball, file = "BYUFootball.csv")

