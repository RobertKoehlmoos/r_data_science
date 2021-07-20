library(tidyverse)
library(nycflights13)
flights |>
  print(n = 10, width = Inf)

read_csv("a,b,c
         1,2,3
         4,5,6")

challenge <- read_csv(
  readr_example("challenge.csv"),
  col_types = cols(
    x = col_double(),
    y = col_date()
  )
)
problems(challenge)

challenge2 <- read_csv(readr_example("challenge.csv"), guess_max = 1001)
problems(challenge2)

write_csv(challenge, "challenge.csv")
# write_rds preserves the r metadata regarding the tibble
# the feather library allows use between languages, and is a little faster