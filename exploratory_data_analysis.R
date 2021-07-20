library(tidyverse)
library(nycflights13)

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

diamonds %>%
  count(cut_width(carat, 0.5))

smaller <- diamonds %>%
  filter(carat < 3)

ggplot(data = smaller, mapping = aes(x = carat)) +
  geom_histogram(binwidth = 0.1)

ggplot(data = smaller, mapping = aes(x = carat, color = cut)) +
  geom_freqpoly(binwidth = 0.1)

ggplot(data = smaller, mapping = aes(x = carat)) +
  geom_histogram(binwidth = 0.01) # this one shows some very interesting trends

ggplot(data = faithful, mapping = aes(x = eruptions)) +
  geom_histogram(binwidth = 0.25) # two clear subgroups

ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = y), binwidth = 0.5) +
  coord_cartesian(ylim = c(0, 50)) # a few clear outliers

unusual <- diamonds %>%
  filter(y < 3 | y > 20) %>%
  arrange(y)
unusual

ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = x))
ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = z))

arrange(diamonds, desc(z))

ggplot(data = diamonds) + 
  geom_histogram(mapping = aes(x = price), binwidth = 100)
diamonds %>%
  count(cut_width(carat, 0.01)) %>%
  view()

diamonds2 <- diamonds %>%
  mutate(y = ifelse(y < 3 | y > 20, NA, y))

ggplot(data = diamonds2) +
  geom_histogram(mapping = aes(x = y))

diamonds_with_cut_NA <- diamonds %>%
  mutate(cut = ifelse(y < 3, NA, cut))

ggplot(data = diamonds_with_cut_NA) +
  geom_bar(mapping = aes(x = cut))

diamonds2 %>%
  group_by(cut) %>%
  summarize(mean(carat))

ggplot(data = diamonds, mapping = aes(x = price, y = ..density..)) +
  geom_freqpoly(mapping = aes(color = cut), binwidth = 500)

ggplot(data = diamonds) + # proving carat is what really matters
  geom_smooth(mapping = aes(x = carat, y = price, color = cut))

ggplot(data = diamonds) + 
  geom_count(mapping = aes(x = cut, y = color))

diamonds %>%
  count(color, cut) %>%
  ggplot(mapping = aes(x = cut, y = color)) +
  geom_tile(mapping = aes(fill = n))

flights %>%
  group_by(dest, month) %>%
  summarize(avg_delay = mean(arr_delay, na.rm = TRUE)) %>%
  ggplot(mapping = aes(x = dest, y = factor(month))) +
  geom_tile(mapping = aes(fill = avg_delay))

ggplot(data = smaller) + # pretty
  geom_hex(mapping = aes(x = carat, y = price))

ggplot(diamonds, aes(carat, price)) +
  geom_hex()
ggsave("diamonds.pdf")

