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
    unzip(FILE_PATH, exdir = here(RAW_DIR))
  }
  
  # Creating sample dataset if not done already with n_samples
  if (0 == length(list.files(here(PROCESSED_DIR),no.. = TRUE))){
    for (file in FILES_PATH) {
      n <- countLines(file)
      train <- TRUE & rbinom(10, size = 1, prob = 0.75)
      tmp <- read_lines(FILES_PATH[1])
      write_lines(tmp[train], here(PROCESSED_DIR, paste0("train.", basename(file))))
      write_lines(tmp[!train], here(PROCESSED_DIR, paste0("test.", basename(file))))
    }
  }
}