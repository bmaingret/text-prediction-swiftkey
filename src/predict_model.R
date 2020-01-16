predict <- function(words, model){
  tok <- words %>% tokens(remove_numbers = TRUE,
         remove_punct = TRUE,
         remove_symbols = TRUE,
         remove_separators = TRUE,
         remove_twitter = TRUE,
         remove_hyphens = TRUE,
         remove_url = TRUE) %>%
    tokens_tolower() %>% unlist()
  
  ntok <- length(tok)
  lookups <- sapply(seq_along(tok), function(i){paste(tok[i:ntok], collapse = "_")})
  
  results <- c()
  lookup <- 1
  n_matches <- 0
  
  while (n_matches<5 && lookup<=ntok){
    matches <- model %>% filter(ngram==lookups[lookup]) %>% top_n(5-n_matches, frequency) %>% select(nextword) %>% unlist()
    results <- c(results, matches)
    lookup <- lookup+1
    n_matches <- sum(results!="")
  }
  results
}
