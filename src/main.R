set.seed(123)

require(here)

source(here("src/utils.R"))
source(here("src/make_dataset.R"))
source(here("src/build_model.R"))
source(here("src/predict_model.R"))


# TODO: bias since every files might not have the same length of lines
make_dataset()

# data <- unlist(sapply(here(PROCESSED_DIR, paste0("train.", FILENAMES)),  read_lines))
data <- unlist(lapply(here(SAMPLES_DIR, paste0("train.", FILENAMES)),  read_lines))


model <- build_model(data, maxorder=5)

# Saving model
saveRDS(model, here("models/model1"))


source("C:/git_repos/dsci-benchmark/benchmark.R")
