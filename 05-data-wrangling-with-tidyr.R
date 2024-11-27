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
#' How many different key_IDs are there?
interviews %>% 
  select(key_ID) %>% 
  distinct() %>% 
  count()

#' How many different instanceIDs are there?
interviews %>% 
  select(instanceID) %>% 
  distinct() %>% 
  count()

#' The current is a “long” data format, where each observation occupies only
#' one row in the dataframe.
#' sample_n() returns a random observations from the whole dataset 
#' - each column is a variable
#' - each row is an observation
#' - each value has its own cell
interviews %>%
  filter(village == "Chirodzo") %>%
  select(key_ID, village, interview_date, instanceID) %>%
  sample_n(size = 10)

#' “wide” data format we see modifications to rule 1, where each column
#' no longer represents a single variable. Instead, columns can represent
#' different levels/values of a variable. For instance, in some data you
#' encounter the researchers may have chosen for every survey date to be
#' a different column.

#' pivot_wider()
#' three principal arguments:
#' 1. the data
#' 2. the names_from column variable whose values will become new column names.
#' 3. the values_from column variable whose values will fill the new column
#'    variables.

#' separate_longer_delim():
#'   separates the values of items_owned based on the presence of semi-colons (;)
interviews %>%
  select(key_ID, items_owned) %>% 
  separate_longer_delim(items_owned, delim = ";")

#' replace_na(): replaces NAs in given columns to some value
#' parameter: list(column1 = "replace to this", column2 = "replace to that")
interviews %>%
  select(key_ID, items_owned) %>% 
  separate_longer_delim(items_owned, delim = ";") %>% 
  replace_na(list(items_owned = "no_listed_items")) %>% 
  filter(items_owned == 'no_listed_items')

#' mutate() create a new variable named items_owned_logical
interviews %>%
  separate_longer_delim(items_owned, delim = ";") %>%
  replace_na(list(items_owned = "no_listed_items")) %>%
  group_by(key_ID) %>%
  mutate(items_owned_logical = TRUE) %>% 
  select(key_ID, items_owned, items_owned_logical)

#' if_else(CONDITION, value if it is TRUE, value if it is FALSE)
interviews %>%
  separate_longer_delim(items_owned, delim = ";") %>%
  replace_na(list(items_owned = "no_listed_items")) %>%
  group_by(key_ID) %>% 
  mutate(number_items = if_else(items_owned == "no_listed_items", 0, n())) %>% 
  select(key_ID, number_items) %>% 
  filter(number_items < 2)

#' pivot_wider()
#' - creates a new column for each of the unique values in the items_owned 
#'   column, 
#' - fills those columns with the values of items_owned_logical. 
#' - for items that are missing, fill cells with FALSE instead of NA
interviews_items_owned <- interviews %>%
  separate_longer_delim(items_owned, delim = ";") %>%
  replace_na(list(items_owned = "no_listed_items")) %>%
  group_by(key_ID) %>%
  mutate(items_owned_logical = TRUE,
         number_items = if_else(items_owned == "no_listed_items", 0, n())) %>%
  pivot_wider(names_from = items_owned,
              values_from = items_owned_logical,
              values_fill = list(items_owned_logical = FALSE))
view(interviews_items_owned)

#' the number of respondents in each village who owned a particular item (bike)
interviews_items_owned %>%
  filter(bicycle) %>%
  group_by(village) %>%
  count(bicycle)

# average number of items owned by respondents in each village
interviews_items_owned %>%
  group_by(village) %>%
  summarize(mean_items = mean(number_items))

#' -- Exercise --
#' We created interviews_items_owned by reshaping the data: first longer
#' and then wider. Replicate this process with the months_lack_food column
#' in the interviews dataframe. Create a new dataframe with columns for each
#' of the months filled with logical vectors (TRUE or FALSE) and a summary
#' column called number_months_lack_food that calculates the number of months
#' each household reported a lack of food.
#' 
#' Note that if the household did not lack food in the previous 12 months,
#' the value input was “none”.

#' Pivoting longer
#' pivot_longer() takes four principal arguments:
#' 1. the data
#' 2. 'cols': the names of the columns we use to fill the a new values
#'    variable (or to drop).
#' 3. 'names_to': column variable we wish to create from the cols provided.
#' 4. 'values_to': column variable we wish to create and fill with values
#'    associated with the cols provided.
interviews_long <- interviews_items_owned %>%
  pivot_longer(cols = bicycle:car,
               names_to = "items_owned",
               values_to = "items_owned_logical")
view(interviews_long)


#' Exercise
#' We created some summary tables on interviews_items_owned using count and
#' summarise. We can create the same tables on interviews_long, but this will
#' require a different process.
#' 
#' Make a table showing the number of respondents in each village who owned
#' a particular item, and include all items. The difference between this
#' format and the wide format is that you can now count all the items using
#' the items_owned variable.

#' Applying what we learned to clean our data
#' 

## Plotting data
#' 'months_lack_food' column contain multiple months which, as before, are
#' separated by semi-colons (;).
#' interviews_plotting will be used in the next episode
interviews_plotting <- interviews %>%
  ## step 1: (repetition) pivot wider by 'items_owned'
  separate_longer_delim(items_owned, delim = ";") %>%
  replace_na(list(items_owned = "no_listed_items")) %>%
  group_by(key_ID) %>% 
  mutate(
    items_owned_logical = TRUE,
    number_items = if_else(items_owned == "no_listed_items", 0, n())) %>% 
  pivot_wider(
    names_from = items_owned,
    values_from = items_owned_logical,
    values_fill = list(items_owned_logical = FALSE)) %>% 
  ## step 2: (new) pivot wider by 'months_lack_food'
  separate_longer_delim(months_lack_food, delim = ";") %>%
  mutate(
    months_lack_food_logical = TRUE,
    number_months_lack_food = if_else(months_lack_food == "none", 0, n())) %>%
  pivot_wider(
    names_from = months_lack_food,
    values_from = months_lack_food_logical,
    values_fill = list(months_lack_food_logical = FALSE))
view(interviews_plotting)

#' Exporting data
#' create directory: 'data_output' for the generated data
dir.create('data_output')
#' write_csv(): generates CSV files from data frames.
write_csv(interviews_plotting, file = "data_output/interviews_plotting.csv")

#'Key Points
#' - Use the tidyr package to change the layout of data frames.
#' - Use pivot_wider() to go from long to wide format. 
#' - Use pivot_longer() to go from wide to long format.

