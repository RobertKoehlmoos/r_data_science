library(tidyverse)
library(nycflights13)

# working with relational data

# add a surogate key to flights
flights_with_primary_key <- flights |>
  mutate(row = row_number()) |>

