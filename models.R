library(tidyverse)
library(modelr)
options(na.action = na.warn)

models <- tibble(
  a1 = runif(250, -20, 40),
  a2 = runif(250, -5, 5)
)

ggplot(sim1, aes(x, y)) +
  geom_point() +
  geom_abline(
    aes(intercept = a1, slope = a2),
    data = models, alpha = 1/4)

model1 <- function(a, data) {
  a[1] + data$x + a[2]
}

sim1_mod <- lm(y ~ x, data = sim1)
coef(sim1_mod)

sim1a <- tibble(
  x = rep(1:10, each = 3),
  y = x * 1.5 + 6 + rt(length(x), df = 2)
)
sim1a_mod <- lm(y ~ x, data = sim1a)

ggplot(sim1a) +
  geom_point(aes(x, y)) +
  geom_abline(intercept = sim1a_mod$coefficients[1],
              slope = sim1a_mod$coefficients[2])

mod <- loess(y ~ x, data = sim1a)N
grid <- data_grid(sim1a, x)
grid <- grid |>
  add_predictions(mod)
ggplot(sim1, aes(x)) +
  geom_point(aes(y = y)) +
  geom_line(aes(y = pred),
            data = grid,
            color = "red",
            size = 1
            )
