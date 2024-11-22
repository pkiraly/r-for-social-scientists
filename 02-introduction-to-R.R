#' Creating objects in R
3 + 5
12 / 7

# assign values to objects
area_hectares <- 1.0

#' key for "<-"
#' win, linux: Alt + -
#' mac: Option + -

#' naming conventions
#' - be explicit and not too long
#' - cannot start with a number (2x is not valid, but x2 is)
#' - case sensitive (weight_kg != Weight_kg)
#' - do not use reserved names (e.g., if, else, for ...). 
#' - do not use other function names
#' - avoid dots (.)
#' - use nouns for object names
#' - use verbs for function names
#' - be consistent in the styling of your code

# doesn't print anything
area_hectares <- 1.0
# putting parenthesis around the call prints the value of `area_hectares`
(area_hectares <- 1.0)  
# and so does typing the name of the object
area_hectares

# convert hectares into acres
2.47 * area_hectares

# change an object's value by assigning it a new one
area_hectares <- 2.5
2.47 * area_hectares

# assigning a value to one object does not change the values of other objects
area_acres <- 2.47 * area_hectares
area_hectares <- 50

#' ++ Exercise ++
#' What do you think is the current content of the object area_acres? 123.5 or 6.175?

#' Comments

area_hectares <- 1.0               # land area in hectares
area_acres <- area_hectares * 2.47 # convert to acres
area_acres                         # print land area in acres.

# add/remove comments:
# Ctrl + Shift + C

#' ++ Exercise ++
#' Create two variables r_length and r_width and assign them values. It should be 
#' noted that, because length is a built-in R function, R Studio might add “()” 
#' after you type length and if you leave the parentheses you will get unexpected
#' results. This is why you might see other programmers abbreviate common words. 
#' Create a third variable r_area and give it a value based on the current values
#' of r_length and r_width. Show that changing the values of either r_length and 
#' r_width does not affect the value of r_area.

# Functions and their arguments
b <- sqrt(a)

round(3.14159)

# get the arguments of a function
args(round)

# get help
?round

# explicit parameters
round(3.14159, digits = 2)

# parameters in fixed order
round(3.14159, 2)

# explicit parameters in mixed order
round(digits = 2, x = 3.14159)

# ++ Exercise ++
# Type in ?round at the console and then look at the output in the Help pane.
# What other functions exist that are similar to round? How do you use the 
# digits parameter in the round function?

# Vectors and data types

hh_members <- c(3, 7, 10, 6)
hh_members

# vector can also contain characters:
respondent_wall_type <- c("muddaub", "burntbricks", "sunbricks")
respondent_wall_type

# get the size
length(hh_members)
length(respondent_wall_type)

# what is the type of an object?
typeof(hh_members)
typeof(respondent_wall_type)

# structure of an object and its elements
str(hh_members)
str(respondent_wall_type)

# add additional elements
possessions <- c("bicycle", "radio", "television")
possessions <- c(possessions, "mobile_phone") # add to the end of the vector
possessions <- c("car", possessions) # add to the beginning of the vector
possessions

#' atomic vector is the simplest R data type
#' "character"
#' "numeric" (or "double")
#' "logical" for TRUE and FALSE (the boolean data type)
#' "integer" for integer numbers (e.g., 2L, the L indicates to R that it's
#'           an integer)
#' "complex" to represent complex numbers with real and imaginary parts
#'           (e.g., 1 + 4i)
#' "raw" for bitstreams
#' 

# ++ Exercise ++
#' We’ve seen that atomic vectors can be of type character, numeric (or 
#' double), integer, and logical. But what happens if we try to mix these
#' types in a single vector?

#' What will happen in each of these examples? (hint: use class() to 
#' check the data type of your objects):
num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")

#' How many values in combined_logical are "TRUE" (as a character) in
#' the following example:
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
combined_logical <- c(num_logical, char_logical)

#' Subsetting vectors

respondent_wall_type <- c("muddaub", "burntbricks", "sunbricks")
#' select one
respondent_wall_type[2]

#' select more
respondent_wall_type[c(3, 2)]

#' with repetitions
more_respondent_wall_type <- respondent_wall_type[c(1, 2, 3, 2, 1, 3)]
more_respondent_wall_type

#' Conditional subsetting
hh_members <- c(3, 7, 10, 6)
hh_members[c(TRUE, FALSE, TRUE, TRUE)]

# will return logicals with TRUE for the indices that meet the condition
hh_members > 5    

## so we can use this to select only the values above 5
hh_members[hh_members > 5]

#' combine multiple tests 
#' & (both conditions are true, AND) or 
#' | (at least one of the conditions is true, OR):
hh_members[hh_members < 4 | hh_members > 7]
hh_members[hh_members >= 4 & hh_members <= 7]

possessions <- c("car", "bicycle", "radio", "television", "mobile_phone")
possessions[possessions == "car" | possessions == "bicycle"] # returns both car and bicycle

#' operators
#' 
#' > for "greater than",
#' < stands for "less than",
#' <= for "less than or equal to",
#' >= for "greater than or equal to",
#' == for "equal to"

#' %in% test if any of the elements of a search vector are found:
possessions %in% c("car", "bicycle")

# get logical vector
possessions %in% c("car", "bicycle", "motorcycle", "truck", "boat", "bus")

# get the values
possessions[possessions %in% c("car", "bicycle", "motorcycle", "truck", "boat", "bus")]

#' Missing data
#' Missing data are represented in vectors as NA
rooms <- c(2, 1, 1, NA, 7)
mean(rooms)
max(rooms)
#' na.rm = TRUE
mean(rooms, na.rm = TRUE)
max(rooms, na.rm = TRUE)

## Extract those elements which are not missing values.
## The ! character is also called the NOT operator
rooms[!is.na(rooms)]

#' Count the number of missing values.
#' The output of is.na() is a logical vector (TRUE/FALSE equivalent to 1/0)
#' so the sum() function here is effectively counting
sum(is.na(rooms))

#' Returns the object with incomplete cases removed. The returned object is
#' an atomic vector of type `"numeric"` (or `"double"`).
na.omit(rooms)

#' Extract those elements which are complete cases. The returned object is
#' an atomic vector of type `"numeric"` (or `"double"`).
rooms[complete.cases(rooms)]

#' ++ Exercise ++
#' Using this vector of rooms, create a new vector with the NAs removed.
rooms <- c(1, 2, 1, 1, NA, 3, 1, 3, 2, 1, 1, 8, 3, 1, NA, 1)

#' Use the function median() to calculate the median of the rooms vector.

#' Use R to figure out how many households in the set use more than 2 rooms for sleeping.

#' Key Points
#' - Access individual values by location using [].
#' - Access arbitrary sets of data using [c(...)].
#' - Use logical operations and logical vectors to access subsets of data.
