#' Processing JSON data
#' 
#' Questions
#' - What is JSON format?
#' - How can I convert JSON to an R dataframe?
#' - How can I convert an array of JSON record into a table?
#' 
#' Objectives
#' - Describe the JSON data format
#' - Understand where JSON is typically used
#' - Appreciate some advantages of using JSON over tabular data
#' - Appreciate some disadvantages of processing JSON documents
#' - Use the jsonLite package to read a JSON file
#' - Display formatted JSON as dataframe
#' - Select and display nested dataframe fields from a JSON document
#' - Write tabular data from selected elements from a JSON document to a csv file

#' The JSON data format
#' - Human readable
#' - it can also be mapped very easily to an R dataframe.
#' 
#' Advantages of JSON
#' - Very popular data format for APIs (e.g. results from an Internet search)
#' - Human readable
#' - Each record (or document as they are called) is self contained.
#'   The equivalent of the column name and column values are in every record.
#' - Documents do not all have to have the same structure within the same file
#' - Document structures can be complex and nested
#' 
#' Disadvantages of JSON
#' - It is more verbose than the equivalent data in csv format
#' - Can be more difficult to process and display than csv formatted data

#' Use the JSON package to read a JSON file
library(jsonlite)

#' read_json() or fromJSON() function, though this does not download the file
json_data <- read_json(
  "https://raw.githubusercontent.com/datacarpentry/r-socialsci/main/episodes/data/SAFI.json"
)

#' download and load
download.file(
  "https://raw.githubusercontent.com/datacarpentry/r-socialsci/main/episodes/data/SAFI.json",
  "data/SAFI.json", mode = "wb"
)

#' default read returns a list
json_data <- read_json("data/SAFI.json")
head(json_data)
View(json_data)

#' simplifyVector
json_data <- read_json("data/SAFI.json", simplifyVector = TRUE)
json_data
glimpse(json_data)

#' convert to tibble
json_data <- json_data %>% as_tibble()
glimpse(json_data)
json_data

# select lists
json_data %>%
  select(where(is.list)) %>%
  glimpse()

json_data$F_liv[1]

#' which(): select cases by a condition. Returns indices
which(json_data$C06_rooms == 4)

json_data$F_liv[which(json_data$C06_rooms == 4)]

#' Write the JSON file to csv: write_csv()
write_csv(json_data, "json_data_with_list_columns.csv")
read_csv("json_data_with_list_columns.csv")

#' as.character command to those columns ‘where’ is.list is TRUE
flattened_json_data <- json_data %>% 
  mutate(across(where(is.list), as.character))
flattened_json_data
flattened_json_data$F_liv

write_csv(flattened_json_data, "data_output/json_data_with_flattened_list_columns.csv")

#' write out the individual nested dataframes to a csv.
write_csv(json_data$F_liv[[1]], "data_output/F_liv_row1.csv")

#' Key Points
#' - JSON is a popular data format for transferring data used by a great many
#'   Web based APIs
#' - The complex structure of a JSON document means that it cannot easily be
#'   ‘flattened’ into tabular data
#' - We can use R code to extract values of interest and place them in a csv file
