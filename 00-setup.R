# only for Windows
if( !("installr" %in% installed.packages()) ){
  install.packages("installr")
}
installr::updateR(TRUE)

#'-- the following command will be issued in the next chapter 
#'-- ENDs here

if( !("tidyverse" %in% installed.packages()) ){
  install.packages("tidyverse")
}
if( !("here" %in% installed.packages()) ){
  install.packages("here")
}

if (!file.exists('data')) {
  dir.create('data')
}

download.file(
  "https://github.com/datacarpentry/r-socialsci/blob/main/episodes/data/SAFI_clean.csv",
  "data/SAFI_clean.csv",
  mode = "wb"
)


download.file(
  "https://github.com/datacarpentry/r-socialsci/blob/main/episodes/data/SAFI.json",
  "data/SAFI.json",
  mode = "wb"
)
