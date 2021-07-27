library(magrittr)
library(lubridate)
library(tidyverse)
library(nycflights13)

rnorm(100) |>
  matrix(ncol = 2) %T>%
  plot() |>
  str()

# functions
rescale01 <- function(x) {
  rng <- range(x, na.rm = TRUE, finite = TRUE)
  y <- (x - rng[1]) / (rng[2] - rng[1])
  y[y == Inf] <- 1
  y[y == -Inf] <- 0
  y
}
x <- c(1:10, Inf)
rescale01(x)

say_current_greeting <- function(time = lubridate::now()) {
  hr <- lubridate::hour(time)
  if (hr < 12) {
    "Good Morning"
  } else if (hr < 1800) {
    "Good Afternoon"
  } else {
    "Good Evening"
  }
}
say_current_greeting()

fizzbuzz <- function(x) {
  if (!(x %% 15)) {
    "fizzbuzz"
  } else if (!(x %% 3)) {
    "fizz"
  } else if (!(x %% 5)) {
    "buzz"
  } else {
    x
  }
}
fizzbuzz(2)

temps <- c(1,5,10,40)
cut(temps, c(-Inf, 0, 10, 20, 30, Inf), c("freezing", "cold", "cool", "warm", "hot"))

commas <- function(...) stringr::str_c(..., collapse = ", ")
commas(letters, collapse = "-")

# iteration ---------------------------------------------------------------

means <- vector("double", length(mtcars))
for (i in seq_along(mtcars)) {
  means[i] <- mean(mtcars[[i]], na.rm = TRUE)
}

for (i in seq_along(flights)) {
  print(typeof(flights[[i]]))
}

iris_unique_per_column <- vector("double", length(iris))
names(iris_unique_per_column) <- names(iris)
for (i in seq_along(iris)) {
  iris_unique_per_column[i] <- n_distinct(iris[[i]])
}

show_mean <- function(df, digits = 2) {
  # Get max length of all variable names in the dataset
  maxstr <- max(str_length(names(df)))
  for (nm in names(df)) {
    if (is.numeric(df[[nm]])) {
      cat(
        str_c(str_pad(str_c(nm, ":"), maxstr + 1L, side = "right"),
              format(mean(df[[nm]]), digits = digits, nsmall = digits),
              sep = " "
        ),
        "\n"
      )
    }
  }
}
show_mean(iris)

# functional programming --------------------------------------------------

map_dbl(mtcars, mean)
map(flights, typeof)
map(iris, n_distinct)
map(c(-10, 0, 10, 100), ~rnorm(10, .))
