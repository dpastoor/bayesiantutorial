# only so pipe is loaded, likely will never be a load order issue 
# so not concerned about invoking it in the script
library(magrittr) 
#' generate demographics as established in dataset_creation.Rmd
#' @param .n_inds number of individuald to generate demographic values for
generate_demographics <- function(.n_inds) {
   slice_inds <- 0
   if (.n_inds < 5) {
     # mvrnorm simulation can be buggy with less than 4 but will be extra precautious
     slice_inds <- .n_inds
     .n_inds <- 5
   }
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
  cov_matrix <- structure(c(2.35423791493776, -0.22374619813278, 20.8948593399032, 
                            77.325835480982, 13.0750618948824, -0.22374619813278, 0.0831201106500692, 
                            -3.14228013459544, -9.36352270029391, -1.21360684647303, 20.8948593399032, 
                            -3.14228013459544, 496.297653308368, 790.361102305602, 110.468402299447, 
                            77.325835480982, -9.36352270029391, 790.361102305602, 2913.10363152414, 
                            460.914218343707, 13.0750618948824, -1.21360684647303, 110.468402299447, 
                            460.914218343707, 105.259163208852), .Dim = c(5L, 5L), .Dimnames = list(
                              c("WT", "CRE", "AGE", "PMA", "HT"), c("WT", "CRE", "AGE", 
                                                                    "PMA", "HT")))
  
  # WT - KG
  # CRE - mg/dL
  # AGE - days
  # HT - cm
  demog_means <- c("WT" = 2.439, "CRE" = 0.551, "AGE" = 22.98, 
                   "PMA" = 252.41, "HT" = 44.485)
  
  # to trim resampled values
  demog_mins <- c("WT" = 0.6, "CRE" = 0.2, "AGE" = 1, "PMA" = 155, "HT" = 20)
  
  
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
  if (slice_inds) {
    # revert back to true amount after oversimulating
    .n_inds <- slice_inds
  }
  return(sample_ids %>% dplyr::slice(1:.n_inds))

}

testthat::test_that("generate_demographics behaves", {
  generate_1 <- generate_demographics(1)
  generate_10 <- generate_demographics(10)
  generate_100 <- generate_demographics(100)
  testthat::expect_equal(nrow(generate_1), 1)
  testthat::expect_equal(nrow(generate_10), 10)
  testthat::expect_equal(nrow(generate_100), 100)
})