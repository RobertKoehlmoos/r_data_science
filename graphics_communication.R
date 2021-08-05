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
