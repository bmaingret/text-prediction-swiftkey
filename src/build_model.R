require(tidyr)
require(dplyr)
require(quanteda)
require(stringr)


#' Build required features for our model
#' 
#' @param maxorder max order for n-grams generation.
#' @return A dataframe with our features.
#' 
#' 


build_model <- function(data, maxorder = 4){
  quanteda_options(threads=6)
  
  tfm <- corpus(data) %>%
    corpus_reshape(to = "sentences") %>%
    tokens(remove_numbers = TRUE,
           remove_punct = TRUE,
           remove_symbols = TRUE,
           remove_separators = TRUE,
           remove_twitter = TRUE,
           remove_hyphens = TRUE,
           remove_url = TRUE,
           ngrams = seq(1,maxorder)) %>% 
    dfm() %>%
    textstat_frequency() %>%
    as.data.frame() %>%
    filter(frequency>4) %>%
    extract(feature, into=c("ngram", "nextword"), regex="(.*(?=_))?_*(.*)") %>%
    select(ngram, nextword, frequency, rank)
  
    # only keep the 5 most frequent 1 gram
    onegram <- tfm %>% filter(is.na(ngram)) %>% top_n(5, frequency)
    tfm <- tfm %>% filter(!is.na(ngram)) %>% bind_rows(onegram)
      
  tfm
  
}

#  regex="(.*(?=_))_(.*)")
#tokens_remove("^[\\p{P}]+$", padding = TRUE, valuetype = "regex") %>%

# 
# tokens_replace()
# # Text frequencies
# freqs <- tibble()
# for (i in 1:5){
#   freqs <- corpus_web %>%
#     get_dfm(ngrams=i) %>%
#     get_textstat() %>%
#     mutate(ngrams=i) %>%
#     bind_rows(freqs)
# }
# 
# freqs <- freqs %>%
#   mutate(frequency=frequency*100) %>%
#   mutate(ngrams=as.factor(ngrams)) %>%
#   group_by(group, ngrams) %>%
#   mutate(cs = cumsum(frequency)) %>%
#   mutate(index = row_number())
# }