#' Data Visualisation with ggplot2
#' Questions
#' - What are the components of a ggplot?
#' - What are the main differences between R base plots, lattice, and ggplot?
#' - How do I create scatterplots, boxplots, and barplots?
#' - How can I change the aesthetics (ex. colour, transparency) of my plot?
#' - How can I create multiple plots at once?
#' 
#' Objectives
#' - Produce scatter plots, boxplots, and barplots using ggplot.
#' - Set universal plot settings.
#' - Describe what faceting is and apply faceting in ggplot.
#' - Modify the aesthetics of an existing ggplot plot (including axis labels
#'   and colour).
#' - Build complex and customized plots from data in a data frame.
#' - Recognize the differences between base R, lattice, and ggplot
#'   visualizations.

#' ggplot2 is also included in the tidyverse package
library(tidyverse)

#' load the data we saved in the previous lesson
interviews_plotting <- read_csv("data_output/interviews_plotting.csv")

#' or if you did not created it, download it
#' interviews_plotting <- read_csv("https://raw.githubusercontent.com/datacarpentry/r-socialsci/main/episodes/data/interviews_plotting.csv")

#' Visualization Options in R

#' R Base Plots
plot(interviews_plotting$no_membrs, interviews_plotting$liv_count,
     main = "Base R Scatterplot",
     xlab = "Number of Household Members",
     ylab = "Number of Livestock Owned")

#' Lattice: multi-panel plots
#' - define the entire plot in a single function call
#' - modifications after plotting are limited
library(lattice)
xyplot(liv_count ~ no_membrs | village, data = interviews_plotting,
       main = "Lattice Plot: Livestock Count by Household Members",
       xlab = "Number of Household Members",
       ylab = "Number of Livestock Owned")

#' Plotting with ggplot2
#' - create complex plots from data stored in a data frame
#' - programmatic interface for 
#'   - specifying what variables to plot, 
#'   - how they are displayed, 
#'   - and general visual properties
#' - work best with data in the ‘long’ format
#' 
#' Each chart built with ggplot2 must include
#' - Data
#' - Aesthetic mapping (aes)
#'   - how variables are mapped onto graphical attributes
#'   - visual attributes: e.g. x-y axes, color, fill, shape, alpha
#' - geometric objects (geom)
#'   - how values are rendered graphically, as bars (geom_bar), 
#'     scatterplot (geom_point), line (geom_line), etc.
#'
#' template:
#' <DATA> %>%
#'   ggplot(aes(<MAPPINGS>)) +
#'   <GEOM_FUNCTION>()

#' step 1: launch ggplot
interviews_plotting %>%
  ggplot()

#' step 2: define a mapping
interviews_plotting %>%
  ggplot(aes(x = no_membrs, y = number_items))

#' step 3: add geometric objects
#' - geom_point() for scatter plots, dot plots, etc.
#' - geom_boxplot() for boxplots!
#' - geom_line() for trend lines, time series, etc.
interviews_plotting %>%
  ggplot(aes(x = no_membrs, y = number_items)) +
  geom_point()

#' using intermediate steps
# Assign plot to a variable
interviews_plot <- interviews_plotting %>%
  ggplot(aes(x = no_membrs, y = number_items))

# Draw the plot as a dot plot
interviews_plot +
  geom_point()

## This is the correct syntax for adding layers
interviews_plot +
  geom_point()

## This will not add the new layer and will return an error message
interviews_plot
+ geom_point()

#' Building your plots iteratively
#' The starting point:
interviews_plotting %>%
  ggplot(aes(x = no_membrs, y = number_items)) +
  geom_point()

#' changing the transparency of the points with "alpha" parameter
interviews_plotting %>%
  ggplot(aes(x = no_membrs, y = number_items)) +
  geom_point(alpha = 0.5)

#' jitter our points using the geom_jitter()
interviews_plotting %>%
  ggplot(aes(x = no_membrs, y = number_items)) +
  geom_jitter()

#' specify amount of random motion in the jitter with "with" and "height"
#' default is 40%
interviews_plotting %>%
  ggplot(aes(x = no_membrs, y = number_items)) +
  geom_jitter(alpha = 0.5,
              width = 0.2,
              height = 0.2)

#' specifying a color with "color"
interviews_plotting %>%
  ggplot(aes(x = no_membrs, y = number_items)) +
  geom_jitter(alpha = 0.5,
              color = "blue",
              width = 0.2,
              height = 0.2)

#' colour each village in the plot differently with aes() inside geom_*()
#' use either color or colour
interviews_plotting %>%
  ggplot(aes(x = no_membrs, y = number_items)) +
  geom_jitter(aes(color = village), alpha = 0.5, width = 0.2, height = 0.2)

#' an alternative coloring and using geom_count()
interviews_plotting %>%
  ggplot(aes(x = no_membrs, y = number_items, color = village)) +
  geom_count()

#' Exercise
#' 
#' Use what you just learned to create a scatter plot of rooms by village
#' with the respondent_wall_type showing in different colours. Does this
#' seem like a good way to display the relationship between these
#' variables? What other kinds of plots might you use to show this
#' type of data?

#' Boxplot
interviews_plotting %>%
  ggplot(aes(x = respondent_wall_type, y = rooms)) +
  geom_boxplot()

#' adding points to a boxplot
interviews_plotting %>%
  ggplot(aes(x = respondent_wall_type, y = rooms)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.5,
              color = "tomato",
              width = 0.2,
              height = 0.2)

#' Notice how the boxplot layer is behind the jitter layer?
#' What do you need to change in the code to put the boxplot layer
#' in front of the jitter layer?

#' Exercise
#' Boxplots are useful summaries, but hide the shape of the distribution.
#' For example, if the distribution is bimodal, we would not see it in a
#' boxplot. An alternative to the boxplot is the violin plot, where the
#' shape (of the density of points) is drawn.
#' 
#' Replace the box plot with a violin plot; see geom_violin().

#' Exercise (continued)
#' 
#' So far, we’ve looked at the distribution of room number within wall type.
#' Try making a new plot to explore the distribution of another variable
#' within wall type.
#' Create a boxplot for liv_count for each wall type. Overlay the boxplot
#' layer on a jitter layer to show actual measurements.

#' Exercise (continued)
#' 
#' Add colour to the data points on your boxplot according to whether
#' the respondent is a member of an irrigation association (memb_assoc).

#' Barplots
#' visualizing categorical data
#' accepts a variable for x, and plots the number of instances each value of x
#' appears in the dataset.
interviews_plotting %>%
  ggplot(aes(x = respondent_wall_type)) +
  geom_bar()

#' "fill" to colour bars by the portion of each count that is from each village.
interviews_plotting %>%
  ggplot(aes(x = respondent_wall_type)) +
  geom_bar(aes(fill = village))

#' side-by-side bars: position = “dodge”
interviews_plotting %>%
  ggplot(aes(x = respondent_wall_type)) +
  geom_bar(aes(fill = village), position = "dodge")

#' calculate proportions
percent_wall_type <- interviews_plotting %>%
  filter(respondent_wall_type != "cement") %>%
  count(village, respondent_wall_type) %>%
  group_by(village) %>%
  mutate(percent = (n / sum(n)) * 100) %>%
  ungroup()
percent_wall_type

# excursion - do not run this
#' if you want to include cement, you have to fill data with 0
percent_wall_type <- interviews_plotting %>%
  count(village, respondent_wall_type) %>%
  group_by(village) %>%
  mutate(percent = (n / sum(n)) * 100) %>%
  ungroup() %>% 
  # remove column 'n'
  select(-n) %>% 
  # create columns from respondent_wall_type, and fill with 0 where missing
  pivot_wider(names_from = respondent_wall_type, 
              values_from = percent, 
              values_fill = 0) %>% 
  # turn it back to the long form
  pivot_longer(cols=burntbricks:cement,
               names_to = 'respondent_wall_type',
               values_to = 'percent')
percent_wall_type

percent_wall_type %>%
  ggplot(aes(x = village, y = percent, fill = respondent_wall_type)) +
  geom_bar(stat = "identity", position = "dodge")

#' Exercise
#' Create a bar plot showing the proportion of respondents in each village
#' who are or are not part of an irrigation association (memb_assoc).
#' Include only respondents who answered that question in the calculations
#' and plot. Which village had the lowest proportion of respondents in an
#' irrigation association?

#' Adding Labels and Titles
#' labs()'s arguments:
#' - title – a title
#' - subtitle – a subtitle (smaller text placed beneath the title)
#' - caption – a caption for the plot
#' - ... – any pair of name and value for aesthetics used in the plot
#'         (e.g., x, y, fill, color, size)
percent_wall_type %>%
  ggplot(aes(x = village, y = percent, fill = respondent_wall_type)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Proportion of wall type by village",
       fill = "Type of Wall in Home",
       x = "Village",
       y = "Percent")

#' Faceting
#' to split one plot into multiple plots based on a factor included
#' in the dataset
percent_wall_type %>%
  ggplot(aes(x = respondent_wall_type, y = percent)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title="Proportion of wall type by village",
       x="Wall Type",
       y="Percent") +
  facet_wrap(~ village)

#' theme_bw(): set the background to white using the function
#' theme(panel.grid = element_blank()): remove grid
percent_wall_type %>%
  ggplot(aes(x = respondent_wall_type, y = percent)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title="Proportion of wall type by village",
       x="Wall Type",
       y="Percent") +
  facet_wrap(~ village) +
  theme_bw() +
  theme(panel.grid = element_blank())

#' the percentage of people in each village who own each item:
#' across() allows us to specify
#' - the columns to be summarized (bicycle:no_listed_items)
#' - the calculation. Because our calculation is a bit more complex than is
#'   available in a built-in function, we define a new formula:
#'   - '~' indicates that we are defining a formula,
#'   - 'sum(.x)' gives the number of people owning that item by counting
#'               the number of TRUE values
#'               (.x is shorthand for the column being operated on),
#'   - n() gives the current group size
percent_items <- interviews_plotting %>%
  group_by(village) %>%
  summarize(
    across(
      bicycle:no_listed_items,
      ~ sum(.x) / n() * 100)) %>%
  pivot_longer(bicycle:no_listed_items,
               names_to = "items",
               values_to = "percent")
percent_items

#' multi-paneled bar plot
percent_items %>%
  ggplot(aes(x = village, y = percent)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~ items) +
  theme_bw() +
  theme(panel.grid = element_blank())

#' ggplot2 themes
#' full list: https://ggplot2.tidyverse.org/reference/ggtheme.html
#' theme_minimal(), theme_light() are popular
#' theme_void() a starting point to create a new hand-crafted theme
#' ggthemes package: https://jrnold.github.io/ggthemes/reference/index.html
#' extensions: https://exts.ggplot2.tidyverse.org/

#' Exercise
#' Experiment with at least two different themes. Build the previous plot
#' using each of those themes. Which do you like best?

#' Customization
#' https://raw.githubusercontent.com/rstudio/cheatsheets/main/data-visualization.pdf

#' starting point
percent_items %>%
  ggplot(aes(x = village, y = percent)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~ items) +
  labs(title = "Percent of respondents in each village who owned each item",
       x = "Village",
       y = "Percent of Respondents") +
  theme_bw()

#' increasing the font size: theme(text = element_text(size = 16))
percent_items %>%
  ggplot(aes(x = village, y = percent)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~ items) +
  labs(title = "Percent of respondents in each village who owned each item",
       x = "Village",
       y = "Percent of Respondents") +
  theme_bw() +
  theme(text = element_text(size = 16))

#' line break in title
#' change axis labels
percent_items %>%
  ggplot(aes(x = village, y = percent)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~ items) +
  labs(title = "Percent of respondents in each village \n who owned each item",
       x = "Village",
       y = "Percent of Respondents") +
  theme_bw() +
  theme(
    axis.text.x = element_text(colour = "grey20", size = 12, angle = 45,
                               hjust = 0.5, vjust = 0.5),
    axis.text.y = element_text(colour = "grey20", size = 12),
    text = element_text(size = 16))

#' plot.title = element_text(hjust = 0.5) to centre the title:
grey_theme <- theme(
    axis.text.x = element_text(colour = "grey20", size = 12, angle = 45,
                               hjust = 0.5, vjust = 0.5),
    axis.text.y = element_text(colour = "grey20", size = 12),
    text = element_text(size = 16),
    plot.title = element_text(hjust = 0.5)
    )

percent_items %>%
  ggplot(aes(x = village, y = percent)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~ items) +
  labs(title = "Percent of respondents in each village \n who owned each item",
       x = "Village",
       y = "Percent of Respondents") +
  grey_theme

#' Exercise
#' With all of this information in hand, please take another five minutes
#' to either improve one of the plots generated in this exercise or create
#' a beautiful graph of your own. Use the RStudio ggplot2 cheat sheet for
#' inspiration. Here are some ideas:
#' 
#' - See if you can make the bars white with black outline.
#' - Try using a different colour palette (see 
#'   http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/).

#' save with ggsave()
my_plot <- percent_items %>%
  ggplot(aes(x = village, y = percent)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~ items) +
  labs(title = "Percent of respondents in each village \n who owned each item",
       x = "Village",
       y = "Percent of Respondents") +
  theme_bw() +
  theme(axis.text.x = element_text(color = "grey20", size = 12, angle = 45,
                                   hjust = 0.5, vjust = 0.5),
        axis.text.y = element_text(color = "grey20", size = 12),
        text = element_text(size = 16),
        plot.title = element_text(hjust = 0.5))

ggsave("fig_output/name_of_file.png", my_plot, width = 15, height = 10)

#' Key Points
#' - ggplot2 is a flexible and useful tool for creating plots in R.
#' - The data set and coordinate system can be defined using the ggplot function.
#' - Additional layers, including geoms, are added using the + operator.
#' - Boxplots are useful for visualizing the distribution of a continuous variable.
#' - Barplots are useful for visualizing categorical data.
#' - Faceting allows you to generate multiple plots based on a categorical variable.

