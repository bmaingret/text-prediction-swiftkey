require(here)
require(readr)

source(here("src/utils.R"))

make_dataset <- function() {
  # Creating sample dataset if not done already with n_samples
  if (12 != length(list.files(here(PROCESSED_DIR), no.. = TRUE, recursive = TRUE))) {
    # Unziping content if not already done
    if (!file.exists(ZIPOUTPUT_DIR_PATH)) {
      # Downloading file if not present
      if (!file.exists(ZIPFILE_PATH)) {
        download.file(URL, ZIPFILE_PATH)
      }
      unzip(ZIPFILE_PATH, exdir = here(RAW_DIR))
    }
    
    
    
    for (file in FILES_PATH) {
      n <- countLines(file)
      train <- TRUE & rbinom(n, size = 1, prob = 0.75)
      tmp <- read_lines(file)
      
      # Full training/testing files
      write_lines(tmp[train], here(PROCESSED_DIR, paste0("train.", basename(file))))
      write_lines(tmp[!train], here(PROCESSED_DIR, paste0("test.", basename(file))))
      
      # Sample training/testing files with 10% of files
      samples <-  TRUE & rbinom(n, size = 1, prob = 0.1)
      write_lines(tmp[train &
                        samples], here(SAMPLES_DIR, paste0("train.", basename(file))))
      write_lines(tmp[!train &
                        samples], here(SAMPLES_DIR, paste0("test.", basename(file))))
    }
  }
}
