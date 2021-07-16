library(nycflights13)
library(tidyverse)

dec25 <- filter(flights, month == 12, day == 25)
not_cancelled <- filter(flights, !is.na(dep_delay), !is.na(arr_delay))
delays <- not_cancelled %>%
  group_by(tailnum) %>%
  summarize(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )

not_cancelled %>% # replicated count() without using it
  group_by(dest) %>%
  summarise(n = n())

# average delay versus portion delayed by day
group_by(not_cancelled, year, month, day) %>%
  summarize(
    avg_delay = mean(arr_delay),
    portion_delayed = sum(arr_delay > 0) / n()
  ) %>%
  ggplot(mapping = aes(x = avg_delay, y = portion_delayed)) +
  geom_point()

group_by(not_cancelled, dest, carrier) %>%
  summarize(avg_delay = mean(arr_delay)) %>%
  arrange(avg_delay)

group_by(not_cancelled, tailnum) %>%
  summarize(total_delay = mean(arr_delay < 0)) %>%
  arrange(desc(total_delay))
