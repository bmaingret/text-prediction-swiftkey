require(here)
require(readr)

source(here("src/utils.R"))

make_dataset <- function() {
  # Downloading file if not present
  if (!file.exists(ZIPFILE_PATH)) {
    download.file(URL, ZIPFILE_PATH)
  }
  
  # Unziping content if not already done
  if (!file.exists(ZIPOUTPUT_DIR_PATH)) {
    unzip(ZIPFILE_PATH, exdir = here(RAW_DIR))
  }
  
  # Creating sample dataset if not done already with n_samples
  if (0 == length(list.files(here(PROCESSED_DIR),no.. = TRUE))){
    for (file in FILES_PATH) {
      n <- countLines(file)
      train <- TRUE & rbinom(n, size = 1, prob = 0.75)
      tmp <- read_lines(file)
      write_lines(tmp[train], here(PROCESSED_DIR, paste0("train.", basename(file))))
      write_lines(tmp[!train], here(PROCESSED_DIR, paste0("test.", basename(file))))
      
      # Sampling 1% of data
      samples <- TRUE & rbinom(n, size = 1, prob = 0.01)
      write_lines(tmp[train & samples], here(SAMPLES_DIR, paste0("train.", basename(file))))
      write_lines(tmp[!train & samples], here(SAMPLES_DIR, paste0("test.", basename(file))))
    }
  }
}

get_data <- function(source = c("all"), samples = FALSE, set = "train"){
  if ("all" %in% source){
    files <- paste(set, FILENAMES, sep=".")
  }
  else {
    files <- paste(set, LANGUAGE, source, "txt", sep=".")  
  }
  
  if (samples){
    path <- SAMPLES_DIR
  }
  else {
    path <- PROCESSED_DIR
  }
  
  data <-  unlist(sapply(here(path, files), read_lines))
  return(data)
}