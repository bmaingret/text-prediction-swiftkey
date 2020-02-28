URL = "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"
ZIPFILE = "Coursera-SwiftKey.zip"
RAW_DIR = "data/raw"
PROCESSED_DIR = "data/processed"
SAMPLES_DIR = "data/processed/samples"

ZIPOUTPUT_DIR = "final"
FILENAMES  = c("en_US.blogs.txt", "en_US.news.txt", "en_US.twitter.txt")
LANGUAGE = "en_US"

ZIPFILE_PATH = here(RAW_DIR, ZIPFILE)
ZIPOUTPUT_DIR_PATH = here(RAW_DIR, ZIPOUTPUT_DIR)
FILES_PATH = here(RAW_DIR, ZIPOUTPUT_DIR, LANGUAGE,  FILENAMES)

# Count lines by chunk of file
countLines <- function(filename){
  f <- file(filename, open="rb")
  nlines <- 0L
  
  while (length(chunk <- readBin(f, "raw", 65536)) > 0) {
    nlines <- nlines + sum(chunk == as.raw(10L))
  }
  
  close(f)
  
  return(nlines)
}