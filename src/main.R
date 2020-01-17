set.seed(123)

require(here)
require(tibble)

source(here("src/utils.R"))
source(here("src/make_dataset.R"))
source(here("src/build_features.R"))
source(here("src/predict_model.R"))
source(here("src/train_model.R"))

# TODO: bias since every files might not have the same length of lines
make_dataset()
data <- get_data(source = c("all"), samples=TRUE, set = "train")

features <- build_features(data, maxorder=7)


test = "at the"
predict(test, features)

