
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
kable(head(sample_ids))
```

    WT     CRE     AGE   PMA     HT  SEX    
------  ------  ------  ----  -----  -------
 3.263   0.557    9.99   270   45.9  FEMALE 
 4.389   0.423   55.58   348   51.0  MALE   
 2.659   0.720   36.76   242   53.1  FEMALE 
 0.921   0.643   39.31   241   34.4  FEMALE 
 2.898   0.269   33.18   279   41.5  FEMALE 
 3.941   0.563   31.29   256   58.3  MALE   



```r
devtools::session_info()
#> Session info --------------------------------------------------------------
#>  setting  value                       
#>  version  R version 3.3.2 (2016-10-31)
#>  system   x86_64, mingw32             
#>  ui       RTerm                       
#>  language (EN)                        
#>  collate  English_United States.1252  
#>  tz       America/New_York            
#>  date     2016-12-06
#> Packages ------------------------------------------------------------------
#>  package   * version date       source        
#>  backports   1.0.4   2016-10-24 CRAN (R 3.3.2)
#>  bookdown    0.2     2016-11-12 CRAN (R 3.3.2)
#>  devtools    1.12.0  2016-06-24 CRAN (R 3.3.2)
#>  digest      0.6.10  2016-08-02 CRAN (R 3.3.2)
#>  evaluate    0.10    2016-10-11 CRAN (R 3.3.2)
#>  htmltools   0.3.5   2016-03-21 CRAN (R 3.3.2)
#>  httpuv      1.3.3   2015-08-04 CRAN (R 3.3.2)
#>  knitr       1.15    2016-11-09 CRAN (R 3.3.2)
#>  magrittr    1.5     2014-11-22 CRAN (R 3.3.2)
#>  memoise     1.0.0   2016-01-29 CRAN (R 3.3.2)
#>  mime        0.5     2016-07-07 CRAN (R 3.3.2)
#>  miniUI      0.1.1   2016-01-15 CRAN (R 3.3.2)
#>  R6          2.2.0   2016-10-05 CRAN (R 3.3.2)
#>  Rcpp        0.12.8  2016-11-17 CRAN (R 3.3.2)
#>  rmarkdown   1.2     2016-11-21 CRAN (R 3.3.2)
#>  rprojroot   1.1     2016-10-29 CRAN (R 3.3.2)
#>  shiny       0.14.2  2016-11-01 CRAN (R 3.3.2)
#>  stringi     1.1.2   2016-10-01 CRAN (R 3.3.2)
#>  stringr     1.1.0   2016-08-19 CRAN (R 3.3.2)
#>  withr       1.0.2   2016-06-20 CRAN (R 3.3.2)
#>  xtable      1.8-2   2016-02-05 CRAN (R 3.3.2)
#>  yaml        2.1.13  2014-06-12 CRAN (R 3.3.2)
```

