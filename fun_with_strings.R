library(tidyverse)
library(stringr)

#practice
str_view(words, "^[aeiou]")
str_view(words, "[^e]ed$", match = TRUE)
str_view(words, "[^c]ei", match = TRUE)
str_view(words, "q[^u]", match = TRUE)
str_extract(sentences, "\\w+")
str_extract_all(sentences, "\\w+")

str_split("apples, pears, and bananas", ", (and )?")
