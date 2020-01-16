set.seed(123)

require(here)
require(tibble)
source(here("src/utils.R"))
source(here("src/make_dataset.R"))
source(here("src/build_features.R"))
source(here("src/predict_model.R"))
source(here("src/train_model.R"))

# TODO: bias since every files might not have the same length of lines
n_samples = 50000
make_dataset()
data <- as.vector(sapply(here(PROCESSED_DIR, paste0("train.", FILENAMES)),  read_lines, n_max=n_samples))

features <- build_features(data, maxorder=7)


test = "at the"
predict(test, features)

