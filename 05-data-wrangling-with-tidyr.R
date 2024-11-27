# load the tidyverse
library(tidyverse)
library(here)

interviews <- read_csv(here("data", "SAFI_clean.csv"), na = "NULL")

## inspect the data
interviews

## preview the data
# view(interviews)

#' Reshaping with pivot_wider() and pivot_longer()
#' There are essentially three rules that define a “tidy” dataset:
#' 1. Each variable has its own column
#' 2. Each observation has its own row
#' 3. Each value must have its own cell

#' Long and wide data formats
#' 
interviews %>% 
  select(key_ID) %>% 
  distinct() %>% 
  count()

interviews %>%
  select(key_ID, village, interview_date, instanceID)

#'  “long” data format, where each observation occupies only one row in the dataframe.
interviews %>%
  filter(village == "Chirodzo") %>%
  select(key_ID, village, interview_date, instanceID) %>%
  sample_n(size = 10)

#' “wide” data format we see modifications to rule 1, where each column no longer 
#' represents a single variable. Instead, columns can represent different levels/values
#' of a variable. For instance, in some data you encounter the researchers may have chosen
#' for every survey date to be a different column.

#' pivot_wider()
interviews_wide <- interviews %>%
  mutate(wall_type_logical = TRUE) %>%
  pivot_wider(names_from = respondent_wall_type,
              values_from = wall_type_logical,
              values_fill = list(wall_type_logical = FALSE))
interviews_wide

#' pivot_longer()
interviews_long <- interviews_wide %>%
  pivot_longer(cols = burntbricks:sunbricks,
               names_to = "respondent_wall_type",
               values_to = "wall_type_logical")
view(interviews_long)

interviews_long <- interviews_wide %>%
  pivot_longer(cols = c(burntbricks, cement, muddaub, sunbricks),
               names_to = "respondent_wall_type",
               values_to = "wall_type_logical") %>%
  filter(wall_type_logical) %>%
  select(-wall_type_logical)
