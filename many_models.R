library(tidyverse)
library(modelr)

library(gapminder)

ggplot(gapminder, aes(year, lifeExp, group = country)) +
  geom_line()

nz <- filter(gapminder, country == "New Zealand")

ggplot(nz, aes(year, lifeExp)) +
  geom_line() +
  ggtitle("Full data = ")

nz_mod <- lm(lifeExp ~ year, data = nz)
add_predictions(nz, nz_mod) |>
  ggplot(aes(year, pred)) +
  geom_line() +
  ggtitle("Linear trend +")

add_residuals(nz, nz_mod) |>
  ggplot(aes(year, resid)) +
  geom_hline(yintercept = 0, color = "white", size = 3) +
  geom_line() +
  ggtitle("Remaining patter")

by_country <- gapminder |>
  group_by(country, continent) |>
  nest()

country_model <- function(df) {
  lm(lifeExp ~ year, data = df)
}

by_country <- mutate(by_country, model =  map(data, country_model))

by_country <- mutate(by_country, residuals = map2(data, model, add_residuals))

resids <- unnest(by_country, residuals)

resids |>
  ggplot(aes(year, resid)) +
  geom_line(aes(group = country), alpha = 1/2) +
  geom_smooth(se = FALSE)

resids |>
  ggplot(aes(year, resid, group = country)) +
  geom_line(alpha = 0.3) +
  facet_wrap(~continent)


# looking at model quality ------------------------------------------------

broom::glance(nz_mod)  
glanced <- by_country |>
  mutate(glance = map(model, broom::glance)) |>
  unnest(glance, .drop = TRUE)
