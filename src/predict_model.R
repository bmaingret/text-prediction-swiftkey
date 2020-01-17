predict <- function(words, model){
  # Tokenize input strings
  tok <- words %>% tokens(remove_numbers = TRUE,
         remove_punct = TRUE,
         remove_symbols = TRUE,
         remove_separators = TRUE,
         remove_twitter = TRUE,
         remove_hyphens = TRUE,
         remove_url = TRUE) %>%
    tokens_tolower() %>% unlist()
  
  # Build lookup strings with n tokens, then n-1 token, n-2 tokens, etc.
  ntok <- length(tok)
  lookups <- sapply(seq_along(tok), function(i){paste(tok[i:ntok], collapse = "_")})
  
  
  #Search lookups in our model for 5 results at most or once we have looked for all tokens
  results <- c()
  lookup <- 1
  n_matches <- 0
  
  while (n_matches<5 && lookup<=ntok){
    matches <- model %>% 
      filter(ngram==lookups[lookup]) %>% 
      top_n(5-n_matches, frequency) %>% 
      # select(nextword) %>% 
      unlist()
    results <- c(results, matches)
    lookup <- lookup+1
    n_matches <- sum(results!="")
  }
  results
}
