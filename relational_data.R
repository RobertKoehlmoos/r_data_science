library(tidyverse)
library(nycflights13)

# working with relational data

# add a surrogate key to flights
flights_with_primary_key <- flights |>
  mutate(row = row_number())

# learning about mutating joins
flights2 <- flights |>
  select(year:day, hour, origin, dest, tailnum, carrier)

flights2 |>
  select(-origin, -dest) |>
  left_join(airlines, by = "carrier")

# average delay by destination
flights |>
  group_by(dest) |>
  summarize(avg_delay = mean(arr_delay, na.rm = TRUE)) |>
  left_join(airports, by = c("dest" = "faa")) |>
  ggplot(aes(lon, lat)) +
  borders("state") +
  geom_point(aes(size = avg_delay)) +
  coord_quickmap()

# add origin and destination to flights
flights2 |>
  left_join(select(airports, faa, lat, lon), by = c("dest" = "faa")) |>
  left_join(select(airports, faa, lat, lon), by = c("origin" = "faa"))

# relationship between age of plane and delays
inner_join(flights,
           select(planes, tailnum, plane_year = year),
           by = "tailnum"
  ) |>
  mutate(age = year - plane_year) |>
  filter(!is.na(age)) |>
  group_by(age) |>
  summarize(avg_delay = mean(arr_delay, na.rm = TRUE)) |>
  ggplot(aes(age, avg_delay)) +
  geom_point()

# what happened on june 13, 2013
flights |>
  filter(year == 2013 & month == 6 & day == 13) |>
  group_by(dest) |>
  summarize(avg_delay = mean(arr_delay, na.rm = TRUE)) |>
  left_join(airports, by = c("dest" = "faa")) |>
  ggplot(aes(lon, lat)) +
  borders("state") +
  geom_point(aes(size = avg_delay, color = avg_delay)) +
  coord_quickmap()

# flights without tailnums
flights |>
  filter(is.na(tailnum))

flights |>
  anti_join(planes, by = "tailnum") |>
  view()

# flights with planes with over 100 flights
planes_gte_100 <- flights |>
  filter(!is.na(tailnum)) |>
  group_by(tailnum) |>
  count() |>
  filter(n >= 100)

semi_join(flights, planes_gte_100, by = "tailnum")

# does each plane have only one airline?
planes |>
  left_join(select(flights, tailnum, carrier), by = "tailnum") |>
  group_by(tailnum) |>
  summarize(carriers = n_distinct(carrier)) |>
  filter(carriers > 1) |>
  left_join(select(flights, tailnum, carrier)) |>
  distinct()

