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
