# only so pipe is loaded, likely will never be a load order issue 
# so not concerned about invoking it in the script
library(magrittr) 
#' generate demographics as established in dataset_creation.Rmd
#' @param .n_inds number of individuald to generate demographic values for
generate_demographics <- function(.n_inds) {
   
  ## copied in from trim_mins.R don't like to do so but didn't want to worry 
  ## about sourcing paths
  trim_mins <- function(df, .filters, inclusive = TRUE) {
    if (inclusive) {
      for (name in names(.filters)) {
        df <- dplyr::filter_(df, .dots = lazyeval::interp(~ var >= val, 
                                                          var = as.name(name), 
                                                          val = .filters[[name]]))
      }
    } else {
      for (name in names(.filters)) {
        df <- dplyr::filter_(df, .dots = lazyeval::interp(~ var > val, 
                                                          var = as.name(name), 
                                                          val = .filters[[name]]))
        
      }
    }
    return(df)
  }
  

  ## actual param values generated from real world data in neonates -----
  cov_matrix <- structure(c(1.2504924787472, -0.0894884026845637, 0.661592810514541, 
                            7.60498389261745, -0.0894884026845637, 0.0533188187919463, -1.0753788738255, 
                            -0.64935033557047, 0.661592810514541, -1.0753788738255, 79.539990497774, 
                            5.33751013422819, 7.60498389261745, -0.64935033557047, 5.33751013422819, 
                            56.2285906040268), .Dim = c(4L, 4L), 
                          .Dimnames = list(c("WT",  "CRE", "AGE", "HT"), 
                                           c("WT", "CRE", "AGE", "HT")))
  
  # WT - KG
  # CRE - mg/dL
  # AGE - days
  # HT - cm
  demog_means <- c("WT" = 2.424, "CRE" = 0.561, "AGE" = 13.08, "HT" = 44.9)
  
  # to trim resampled values
  demog_mins <- c("WT" = 0.6, "CRE" = 0.2, "AGE" = 1, "HT" = 20)
  
  
  ## ------------------------------------------------------------------------
  # since will be trimming from mins will 'overgenerate' individuals to make sure
  # enough remain after trimming
  # happens so fast no need to optimize
  sample_ids <- MASS::mvrnorm(round(.n_inds*2), 
                              demog_means, 
                              cov_matrix, 
                              empirical = T) %>%
    tibble::as_data_frame() %>% 
    trim_mins(demog_mins) %>% 
    ## generate males and females
    dplyr::mutate(SEX = factor(purrr::rbernoulli(nrow(.)), 
                        labels = c("FEMALE", "MALE")))
  return(sample_ids %>% dplyr::slice(1:.n_inds))

}

testthat::test_that("generate_demographics behaves", {
  generate_10 <- generate_demographics(10)
  generate_100 <- generate_demographics(100)
  testthat::expect_equal(nrow(generate_10), 10)
  testthat::expect_equal(nrow(generate_100), 100)
})