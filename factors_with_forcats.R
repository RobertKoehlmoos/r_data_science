library(tidyverse)
library(forcats)

# proportions of political id by year

number_by_year <- group_by(gss_cat, year) |>
  count()

mutate(gss_cat, partyid = fct_collapse(partyid,
  rep = c("Strong republican", "Not str republican", "Ind,near rep"),
  dem = c("Ind,near dem", "Not str democrat", "Strong democrat"),
  other = c("No answer", "Don't know", "Other party", "Independent"))) |>
  group_by(year, partyid) |> count() |>
  summarize(percent = n/number_by_year[number_by_year$year == year, "n"]) |>
  ggplot(aes(color = partyid)) +
  geom_line(aes(year, percent$n))
