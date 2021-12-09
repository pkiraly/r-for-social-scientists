if( !("installr" %in% installed.packages()) ){
  install.packages("installr")
}
installr::updateR(TRUE)


if (!file.exists('data')){
  dir.create('data')
}
  
download.file(
  "https://ndownloader.figshare.com/files/11492171",
  "data/SAFI_clean.csv",
  mode = "wb"
)


download.file(
  "https://datacarpentry.org/r-socialsci/data/SAFI.json",
  "data/SAFI.json",
  mode = "wb"
)
