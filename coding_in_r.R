library(magrittr)
library(lubridate)

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
