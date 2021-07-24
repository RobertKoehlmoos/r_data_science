library(tidyverse)
library(lubridate)
library(nycflights13)

ymd("20150101") + month(1:11)
get_age_in_years <- function(birthday) {
  (today() %--% birthday) %/% years(1)
}
get_age_in_years(ymd("20020502"))
