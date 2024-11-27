#' Data Manipulation using dplyr and tidyr
#' dplyr is 
#' - a package
#' - for making tabular data manipulation easier
#' - by using a limited set of functions
#' - that can be combined
#' tidyr enables you
#' - to swiftly convert between different data formats (long vs. wide)
#' - for plotting and analysis

#' What is an R package?
#' - complete unit for sharing code with others
#' - it contains
#'   the code for a set of R functions
#'   the documentation (or description) for each of the functions
#'   a practice dataset to learn the functions on
#' - Comprehensive R Archive Network (CRAN)
install.packages()
library()
help(package = "package_name")
#' more on dplyr and tidyr
#' - handy data transformation with dplyr cheatsheet 
#'   https://github.com/rstudio/cheatsheets/raw/master/data-transformation.pdf
#' - Data Import CHEAT SHEET
#'   https://github.com/rstudio/cheatsheets/raw/master/data-import.pdf

#' Learning dplyr and tidyr

# load the tidyverse
library(tidyverse)
library(here)

interviews <- read_csv(here("data", "SAFI_clean.csv"), na = "NULL")

## inspect the data
interviews

# preview the data
view(interviews)

#' most common dplyr functions:
#' select(): subset columns
#' filter(): subset rows on conditions
#' mutate(): create new columns by using information from other columns
#' group_by() and summarize(): create summary statistics on grouped data
#' arrange(): sort results
#' count(): count discrete values

#' Selecting columns and filtering rows

#' select(data_frame, column1, column2, ...) — select columns of a data frame
select(interviews, village, no_membrs, months_lack_food)
# to do the same thing with subsetting
interviews[c("village","no_membrs","months_lack_food")]
# to select a series of connected columns
select(interviews, village:respondent_wall_type)

# filter(df, criteria) — choose rows based on a specific criteria
# filters observations where village name is "Chirodzo" 
filter(interviews, village == "Chirodzo")

# filters observations with "and" operator (comma)
# output dataframe satisfies ALL specified conditions
filter(interviews, village == "Chirodzo", 
       rooms > 1, 
       no_meals > 2)

# filters observations with "&" logical operator
# output dataframe satisfies ALL specified conditions
filter(interviews, village == "Chirodzo" & 
         rooms > 1 & 
         no_meals > 2)

# filters observations with "|" logical operator
# output dataframe satisfies AT LEAST ONE of the specified conditions
filter(interviews, village == "Chirodzo" | village == "Ruaca")

#' Pipes
#' intermediary steps
interviews2 <- filter(interviews, village == "Chirodzo")
interviews_ch <- select(interviews2, village:respondent_wall_type)

# nest functions
interviews_ch <- select(filter(interviews, village == "Chirodzo"),
                        village:respondent_wall_type)

#' pipes
#' %>% (via the magrittr package) (https://en.wikipedia.org/wiki/The_Treachery_of_Images)
#' |> (native R pipe)
#' CTRL + SHIFT + M (Mac: Cmd + SHIFT + M)
#' read the pipe like the word “then”.

interviews %>%
  filter(village == "Chirodzo") %>%
  select(village:respondent_wall_type)

#' or with the "native pipe":
# interviews |>
#   filter(village == "Chirodzo") |>
#   select(village:respondent_wall_type)

#' assign the result
interviews_ch <- interviews %>%
  filter(village == "Chirodzo") %>%
  select(village:respondent_wall_type)

interviews_ch

#' Exercise
#' Using pipes, subset the interviews data to include interviews where respondents
#' were members of an irrigation association (memb_assoc) and retain only the columns
#' affect_conflicts, liv_count, and no_meals.

#' Mutate
#' mutate() — create new columns based on the values in existing columns

interviews %>%
  mutate(people_per_room = no_membrs / rooms)

#' To remove NULL cases
interviews %>%
  filter(!is.na(memb_assoc)) %>%
  mutate(people_per_room = no_membrs / rooms)

#' Exercise
#' Create a new dataframe from the interviews data that meets the following 
#' criteria: contains only the village column and a new column called 
#' total_meals containing a value that is equal to the total number of meals
#' served in the household per day on average (no_membrs times no_meals).
#' Only the rows where total_meals is greater than 20 should be shown 
#' in the final dataframe.
#' Hint: think about how the commands should be ordered to produce this data
#' frame!

#' Split-apply-combine data analysis and the summarize() function
#' the split-apply-combine paradigm:
#' - split the data into groups
#' - apply some analysis to each group
#' - combine the results
#' group_by()

#' The summarize() function
interviews %>%
  group_by(village) %>%
  summarize(mean_no_membrs = mean(no_membrs))

#' multiple columns
interviews %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs))

#' ungroup()
interviews %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs)) %>%
  ungroup()

#' remove NAs
interviews %>%
  filter(!is.na(memb_assoc)) %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs))

#' add more field: minimum household size for each village
interviews %>%
  filter(!is.na(memb_assoc)) %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs),
            min_membrs = min(no_membrs))

#' sort the result with arrange()
interviews %>%
  filter(!is.na(memb_assoc)) %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs),
            min_membrs = min(no_membrs)) %>%
  arrange(min_membrs)

#' reverse sort with desc()
interviews %>%
  filter(!is.na(memb_assoc)) %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs),
            min_membrs = min(no_membrs)) %>%
  arrange(desc(min_membrs))

#' Counting with count()
interviews %>%
  count(village)

# count with sorting
interviews %>%
  count(village, sort = TRUE)

#' Exercise
#' 1. How many households in the survey have an average of two meals per day?
#'    Three meals per day? Are there any other numbers of meals represented?
#'    
#' 2. Use group_by() and summarize() to find the mean, min, and max number
#'    of household members for each village. Also add the number of 
#'    observations (hint: see ?n).
#'
#' 3. What was the largest household interviewed in each month?

