library(tidyverse)


# Graphics to communicate -------------------------------------------------
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  labs(
    title = paste("Fuel efficiency generally decreases with",
                  "engine size"),
    subtitle = paste("Two seaters (sports cars) are an exception",
                     "because of their light weight"),
    caption = "Data from fueleconomy.gov",
    x = "Engine displacement (L)",
    y = "Highway fuel economy (mpg)",
    color = "Car Type"
  )


df <- tibble(
  x = runif(10),
  y = runif(10),
)
ggplot(df, aes(x, y)) +
  geom_point() +
  labs(
    x = quote(sum(x[i]^2, i == 1, n)),
    y = quote(alpha + beta + frac(delta, theta))
  )


# practice -----------------------------------------------------------------

ggplot(mpg, aes(cty, hwy)) +
  geom_point(aes(color = trans)) +
  labs(
    title = "My cool graphixxxs!",
    x = "year",
    y = "miles per gatorade",
    subtitle = "Please hire me",
    color = "Is it color or colour?"
  )

best_in_class <- mpg |>
  group_by(class) |>
  filter(row_number(desc(hwy)) == 1)

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_point(size = 3, shape = 1, data = best_in_class) +
  ggrepel::geom_label_repel(
    aes(label = model),
    data = best_in_class
  )

ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  scale_x_continuous(labels = NULL)

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  theme_dark()
