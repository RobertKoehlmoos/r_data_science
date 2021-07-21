library(tidyverse)

table1 |>
  mutate(rate = cases / population * 10000)

ggplot(table1, aes(year, cases)) +
  geom_line(aes(group = country), color = "grey49") +
  geom_point(aes(color = country))

t2_cases <- filter(table2, type == "cases") |>
  rename(cases = count) |>
  arrange(country, year)

t2_population <- filter(table2, type == "population") |>
  rename(population = count) |>
  arrange(country, year)

t2_rates <- t2_cases$cases / t2_population$population * 10000

t2_with_rates <- tibble(year = t2_cases$year, country = t2_cases$country,
                        cases = t2_cases$cases,
                        population = t2_population$population) |> 
  mutate(count = cases / population * 10000) |>
  mutate(type = "rate") |>
  select(country, year, type, count)

bind_rows(table2, t2_with_rates)

table4c <- tibble(country = table4a$country,
                  `1999` = table4a[['1999']] / table4b[['1999']] * 10000,
                  `2000` = table4a[['2000']] / table4b[['2000']] * 10000)

filter(table2, type == "cases") |>
  ggplot(aes(year, count)) +
  geom_line(aes(group = country), color = "pink") +
  geom_point(aes(color = country))
 
left_join(gather(table4a, `1999`, `2000`, key = "year", value = "cases"), 
          gather(table4b, `1999`, `2000`, key = "year", value = "cases"))

preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes", NA, 10,
  "no", 20, 12
)

preg_tidy <- preg |>
  gather(`male`, `female`, key = "gender", value = "count")

# separate and unite
separate(table3, rate, c("cases", "population"), convert = TRUE)

# case study

who1 <- gather(who,
       new_sp_m014:newrel_f65,
       key = "key",
       value = 'cases',
       na.rm = TRUE) |>
  arrange(country, year)

who2 <- who1 |>
  mutate(key = stringr::str_replace(key, "newrel", "new_rel"))
who3 <- who2 |>
  separate(key, c("new", "type", "sexage"), sep = "_")
who3 |>
  select(-new, -iso2, -iso3) |>
  separate(sexage, c("sex", "age"), sep = 1)
