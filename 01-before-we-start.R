#' What is R? What is RStudio?
#' R is
#' - programming language
#' - the software that interprets the scripts

#' RStudio
#' * write your R scripts
#' * interact with the R software
#' * IDE (Integrated Development Interface) — tools to make programming easier

#' Why learn R?
#' - R does not involve lots of pointing and clicking, 
#'   and that’s a good thing
#'   * do not rely on remembering a succession of pointing and clicking, but
#'     instead on a series of written commands
#'   * can be inspected by someone else (feedback and spot mistakes)
#'   * deeper understanding of what you are doing

#' - R code is great for reproducibility
#'   * same results
#'   * from the same dataset
#' 	 * using the same analysis
#'   * generate manuscripts
#'   * is a requirement

#' - R is interdisciplinary and extensible
#'   * 10,000+ packages
#'   * disciplines
#'   * methods: image analysis, GIS, time series, population genetics etc.

#' - R works on data of all shapes and sizes
#'   * volume of data
#'   * connect to spreadsheets, databases, and many other data formats

#' - R produces high-quality graphics
#'   * plotting

#' - R has a large and welcoming community
#'   * Stack Overflow: https://stackoverflow.com/
#'   * RStudio community: https://community.rstudio.com/
#'   * short, reproducible code snippets: https://www.tidyverse.org/help/

#' - Not only is R free, but it is also open-source and cross-platform
#'   * inspect the source code → report and fix bugs
#'   * third-party add-on packages

#' A tour of RStudio
#' * open-source, Affero General Public License (AGPL) v3.
#' * commercial license is available
#' * write code
#' * navigate the files
#' * inspect the variables
#' * visualize the plots
#' * and more...
#'   * version control
#' 	 * developing packages
#' 	 * writing Shiny apps
#' * shortcuts
#' * autocompletion
#' * code highlight

#' Getting set up
#' * working directory
#' * relative path
#' * “Projects” interface

#' Create a new project
#' - File > New project > New directory > New project
#' - enter a name
#' - click on Create project
#' - File > New File > R script
#' 
#' The RStudio Interface
#' * "panes"
#' * customization: Tools > Global Options > Pane Layout
#' 	* Source
#' 	* Console: what R would look and be like without RStudio
#' 	* Enviornment/History: what you have done
#' 	* Files and more: contents of the project/working directory here, like your Script.R file

#' Organizing your working directory
#' - data/ to store your raw data and intermediate datasets. 
#'         For the sake of transparency and provenance, you should
#'         always keep a copy of your raw data accessible and do as
#'         much of your data cleanup and preprocessing programmatically
#'         (i.e., with scripts, rather than manually) as possible.
#' - data_output/ to store the modified versions of the datasets
#' - documents/ Used for outlines, drafts, and other text.
#' - fig_output/ This folder can store the graphics that are generated
#'         by your scripts.
#' - scripts/ A place to keep your R scripts for different analyses
#'         or plotting.

dir.create("data")
dir.create("data_output")
dir.create("fig_output")

download.file("https://ndownloader.figshare.com/files/11492171",
              "data/SAFI_clean.csv", mode = "wb")

#' Interacting with R
#' * instructions are commands
#' * executing/running a command
#' * script files: plain text files that contain your code
#' * in console: [command] + ENTER
#' * in source pane: [command] + CTRL + ENTER (Mac: CMD + RETURN)
#' * clear console: CTRL + L
#' * more keyboard shortcuts: https://github.com/rstudio/cheatsheets/raw/master/rstudio-ide.pdf
#' * to source: CTRL + 1
#' * to console: CTRL + 2
#' * > prompt
#' * + prompt — something is missing, you have to continue
#' * ESC — finish typing
#' 
#' Installing additional packages using the packages tab
#' * central repositories
#' * CRAN
#' * ggplot2, dplyr
#' * packages tab > ‘Install’ icon > type
#' 	* check box to ‘Install dependencies’
#' * install.packages("tidyverse")

if(!("tidyverse" %in% installed.packages())){
  install.packages("tidyverse")
}

if(!("here" %in% installed.packages())){
  install.packages("here")
}

