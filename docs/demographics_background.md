
# Demographics Background


```r
library(knitr)
library(PKPDmisc)
library(tidyverse)
```


```r
source("../scripts/generate_demographics.R")
#> 
#> Attaching package: 'magrittr'
#> The following object is masked from 'package:purrr':
#> 
#>     set_names
#> The following object is masked from 'package:tidyr':
#> 
#>     extract
```

The following covariance matrix was generated from 
fitting the baseline demographics from a couple hundred neonates in a hospital setting, primarily the NICU.


```r
sample_ids <- generate_demographics(500) %>% 
  ## generate males and females
  mutate(SEX = factor(rbernoulli(nrow(.)), 
                      labels = c("FEMALE", "MALE")))
```

This functionality is encapsulated in the script `generate_demographics.R` for use
in other files.


```r
GGally::ggpairs(sample_ids)
#> `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
#> `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
#> `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
#> `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
#> `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

<img src="demographics_background_files/figure-html/unnamed-chunk-5-1.png" width="672" />


```r
head(sample_ids)
#> # A tibble: 6 × 6
#>      WT   CRE   AGE   PMA    HT    SEX
#>   <dbl> <dbl> <dbl> <dbl> <dbl> <fctr>
#> 1 3.263 0.557  9.99   270  45.9 FEMALE
#> 2 4.389 0.423 55.58   348  51.0   MALE
#> 3 2.659 0.720 36.76   242  53.1 FEMALE
#> 4 0.921 0.643 39.31   241  34.4 FEMALE
#> 5 2.898 0.269 33.18   279  41.5 FEMALE
#> 6 3.941 0.563 31.29   256  58.3   MALE
```



```r
devtools::session_info()
#> Session info --------------------------------------------------------------
#>  setting  value                       
#>  version  R version 3.3.2 (2016-10-31)
#>  system   x86_64, darwin13.4.0        
#>  ui       X11                         
#>  language (EN)                        
#>  collate  en_US.UTF-8                 
#>  tz       America/New_York            
#>  date     2016-11-17
#> Packages ------------------------------------------------------------------
#>  package   * version  date       source                            
#>  backports   1.0.4    2016-10-24 CRAN (R 3.3.0)                    
#>  bookdown    0.1      2016-07-13 CRAN (R 3.3.0)                    
#>  devtools    1.12.0   2016-06-24 CRAN (R 3.3.0)                    
#>  digest      0.6.10   2016-08-02 CRAN (R 3.3.0)                    
#>  evaluate    0.10     2016-10-11 CRAN (R 3.3.0)                    
#>  formatR     1.4      2016-05-09 CRAN (R 3.3.0)                    
#>  htmltools   0.3.5    2016-03-21 CRAN (R 3.3.0)                    
#>  httpuv      1.3.3    2015-08-04 CRAN (R 3.3.0)                    
#>  knitr       1.14     2016-08-13 CRAN (R 3.3.0)                    
#>  magrittr    1.5      2014-11-22 CRAN (R 3.3.0)                    
#>  memoise     1.0.0    2016-01-29 CRAN (R 3.3.0)                    
#>  mime        0.5      2016-07-07 CRAN (R 3.3.0)                    
#>  miniUI      0.1.1    2016-01-15 CRAN (R 3.3.0)                    
#>  R6          2.2.0    2016-10-05 CRAN (R 3.3.0)                    
#>  Rcpp        0.12.7   2016-09-05 CRAN (R 3.3.0)                    
#>  rmarkdown   1.1.9014 2016-11-16 Github (rstudio/rmarkdown@91c7de2)
#>  rprojroot   1.1      2016-10-29 CRAN (R 3.3.0)                    
#>  shiny       0.14.2   2016-11-01 CRAN (R 3.3.0)                    
#>  stringi     1.1.2    2016-10-01 CRAN (R 3.3.0)                    
#>  stringr     1.1.0    2016-08-19 CRAN (R 3.3.0)                    
#>  withr       1.0.2    2016-06-20 CRAN (R 3.3.0)                    
#>  xtable      1.8-2    2016-02-05 CRAN (R 3.3.0)                    
#>  yaml        2.1.13   2014-06-12 CRAN (R 3.3.0)
```

