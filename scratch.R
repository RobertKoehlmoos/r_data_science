library(tidyverse)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~cty)
ggplot(data = mpg) + 
  geom_point(size = 4, mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)
dim(mtcars)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv, color = drv)) +
  geom_point(mapping = aes(x = displ, y = hwy, color = drv))
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = drv))

# enough car stuff, time for messing around with the diamonds data
ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut, fill = clarity))

ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) +
  geom_bar(position = "dodge")

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_count(name = "nums")

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = class, y = displ)) +
  coord_flip()

nz <- map_data("nz")
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", color = "black") +
  coord_map() # maps with New Zealand!

ggplot(data = diamonds) + # this graph is garbage
  geom_point(mapping = aes(x = carat, y = price)) +
  coord_polar() # this one makes my computer wait a minute
