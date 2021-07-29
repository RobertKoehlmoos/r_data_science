library(tidyverse)
library(modelr)
options(na.action = na.warn)

library(nycflights13)
library(lubridate)


# Advanced Modeling -------------------------------------------------------

ggplot(diamonds, aes(cut, price)) + geom_boxplot()
ggplot(diamonds, aes(color, price)) + geom_boxplot()
ggplot(diamonds, aes(clarity, price)) + geom_boxplot()

diamonds2 <- diamonds |>
  filter(carat <= 2.5) |>
  mutate(lprice = log2(price), lcarat = log2(carat))

ggplot(diamonds2, aes(lcarat, lprice)) + geom_hex(bins = 50)

mod_diamond <- lm(lprice ~ lcarat, data = diamonds2)

grid <- diamonds2 |>
  data_grid(carat = seq_range(carat, 20)) |>
  mutate(lcarat = log2(carat)) |>
  add_predictions(mod_diamond, "lprice") |>
  mutate(price = 2 ^ lprice)

ggplot(diamonds2, aes(carat, price)) +
  geom_hex(bins = 50) +
  geom_line(data = grid, color = "red", size = 1)


# Modeling Daily Flights --------------------------------------------------

daily <- flights |>
  mutate(date = make_date(year, month, day)) |>
  group_by(date) |>
  summarize(n = n())

ggplot(daily, aes(date, n)) +
  geom_line()

daily <- daily |>
  mutate(wday = wday(date, label = TRUE))

mod <- lm(n ~ wday, data = daily)

grid <- daily |>
  data_grid(wday) |>
  add_predictions(mod, "n")

ggplot(daily, aes(wday, n)) +
  geom_boxplot() +
  geom_point(data = grid, color = "red", size = 4)

daily <- daily |>
  add_residuals(mod)

daily |>
  ggplot(aes(date, resid)) +
  geom_ref_line(h = 0) +
  geom_line()

ggplot(daily, aes(date, resid, color = wday)) +
  geom_ref_line(h = 0) +
  geom_line()

# I still don't entirely get it, but that's okay. All the real modeling happens
# in python