require(dplyr)
require(quanteda)

predict <- function(words, model) {
  max_matches <- 3
  
  tok <- words %>% tokens(
    remove_numbers = TRUE,
    remove_punct = TRUE,
    remove_symbols = TRUE,
    remove_separators = TRUE,
    remove_twitter = TRUE,
    remove_hyphens = TRUE,
    remove_url = TRUE
  ) %>%
    tokens_tolower() %>% unlist()
  
  # Create the possible lookups from the serach sentence
  ntok <- length(tok)
  lookups <-
    sapply(seq_along(tok), function(i) {
      paste(tok[i:ntok], collapse = "_")
    })
  
  
  #Search lookups in our model for 5 results at most or once we have looked for all tokens
  results <- c()
  lookup <- 1
  n_matches <- 0
  
  while (n_matches < max_matches && lookup <= length(lookups)) {
    matches <-
      model %>% 
      filter(ngram == lookups[lookup]) %>% 
      top_n(max_matches - n_matches, frequency) %>% 
      select(nextword)
    
    if (nrow(matches) > (max_matches - n_matches)) {
      matches <- matches %>% sample_n(max_matches - n_matches)
    }
    
    matches <- unique(unlist(matches))
    results <- unique(c(results, matches))
    lookup <- lookup + 1
    n_matches <- sum(results != "")
  }
  
  
  # If we a re missing results to get to the number of results we want, we add the most frequent 1-gram
  # Note that the model should only include the top most frequent 1-gram anyway
  if (n_matches < max_matches) {
    unigrams <- model %>% 
      filter(is.na(ngram)) %>% 
      filter(!nextword %in% results) %>% 
      top_n(max_matches-n_matches, frequency) %>% 
      select(nextword) %>% 
      unlist()
    results <- c(results, unigrams)
  }
  
  unname(results)
}
