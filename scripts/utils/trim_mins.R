#' trim simulated distributions to not be below observed min value
#' @param df dataframe to trim
#' @param .filters named vector of column to filter and the minimum value
#' @param inclusive boolean whether to include min value or not
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

testthat::test_that("trim_mins behaves", {
  tconc <- trim_mins(Theoph, c("conc" = 10.21))
  tconc_noinclude <- trim_mins(Theoph, c("conc" = 10.21), inclusive = F)
  tconctime <- trim_mins(Theoph, c("conc" = 5, "Time" = 8))
  tconctime_manual <- dplyr::filter(Theoph, conc > 5, Time > 8)
  testthat::expect_equal(nrow(tconc), 3)
  testthat::expect_equal(nrow(tconc_noinclude), 2)
  testthat::expect_equal(tconctime, tconctime_manual)
})
