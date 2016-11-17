
# Dataset Creation


```r
library(knitr)
library(PKPDmisc)
library(tidyverse)
library(vancomycin)
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

## Generate data for mrgsolve

start with a baseline of having 100 individuals worth of data, can scale to 
different amounts of individuals later


```r
NIDS <- 100
```


```r
demogs <- generate_demographics(NIDS) %>% mutate(ID = 1:nrow(.))
```


```r
for_dosing <- demogs %>% 
                  mutate(
                      CMT = 1, 
                      EVID = 1,
                      TIME = 0
                  )
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
#>  package    * version    date       source                              
#>  assertthat   0.1        2013-12-06 CRAN (R 3.3.0)                      
#>  backports    1.0.4      2016-10-24 CRAN (R 3.3.0)                      
#>  bookdown     0.1        2016-07-13 CRAN (R 3.3.0)                      
#>  codetools    0.2-15     2016-10-05 CRAN (R 3.3.2)                      
#>  colorspace   1.2-7      2016-10-11 CRAN (R 3.3.0)                      
#>  crayon       1.3.2      2016-06-28 CRAN (R 3.3.0)                      
#>  DBI          0.5-1      2016-09-10 CRAN (R 3.3.0)                      
#>  devtools     1.12.0     2016-06-24 CRAN (R 3.3.0)                      
#>  digest       0.6.10     2016-08-02 CRAN (R 3.3.0)                      
#>  dplyr      * 0.5.0      2016-06-24 CRAN (R 3.3.0)                      
#>  evaluate     0.10       2016-10-11 CRAN (R 3.3.0)                      
#>  formatR      1.4        2016-05-09 CRAN (R 3.3.0)                      
#>  ggplot2    * 2.1.0      2016-03-01 CRAN (R 3.3.0)                      
#>  gtable       0.2.0      2016-02-26 CRAN (R 3.3.0)                      
#>  htmltools    0.3.5      2016-03-21 CRAN (R 3.3.0)                      
#>  httpuv       1.3.3      2015-08-04 CRAN (R 3.3.0)                      
#>  knitr      * 1.14       2016-08-13 CRAN (R 3.3.0)                      
#>  lazyeval     0.2.0      2016-06-12 CRAN (R 3.3.0)                      
#>  magrittr   * 1.5        2014-11-22 CRAN (R 3.3.0)                      
#>  MASS         7.3-45     2016-04-21 CRAN (R 3.3.2)                      
#>  memoise      1.0.0      2016-01-29 CRAN (R 3.3.0)                      
#>  mime         0.5        2016-07-07 CRAN (R 3.3.0)                      
#>  miniUI       0.1.1      2016-01-15 CRAN (R 3.3.0)                      
#>  munsell      0.4.3      2016-02-13 CRAN (R 3.3.0)                      
#>  PKPDmisc   * 0.4.4.9000 2016-11-08 Github (dpastoor/PKPDmisc@55c63cc)  
#>  plyr         1.8.4      2016-06-08 CRAN (R 3.3.0)                      
#>  purrr      * 0.2.2      2016-06-18 CRAN (R 3.3.0)                      
#>  R6           2.2.0      2016-10-05 CRAN (R 3.3.0)                      
#>  Rcpp         0.12.7     2016-09-05 CRAN (R 3.3.0)                      
#>  readr      * 1.0.0      2016-08-03 CRAN (R 3.3.0)                      
#>  rmarkdown    1.1.9014   2016-11-16 Github (rstudio/rmarkdown@91c7de2)  
#>  rprojroot    1.1        2016-10-29 CRAN (R 3.3.0)                      
#>  scales       0.4.0      2016-02-26 CRAN (R 3.3.0)                      
#>  shiny        0.14.2     2016-11-01 CRAN (R 3.3.0)                      
#>  stringi      1.1.2      2016-10-01 CRAN (R 3.3.0)                      
#>  stringr      1.1.0      2016-08-19 CRAN (R 3.3.0)                      
#>  testthat     1.0.2      2016-04-23 CRAN (R 3.3.0)                      
#>  tibble     * 1.2        2016-08-26 CRAN (R 3.3.0)                      
#>  tidyr      * 0.6.0      2016-08-12 CRAN (R 3.3.0)                      
#>  tidyverse  * 1.0.0      2016-09-09 CRAN (R 3.3.0)                      
#>  vancomycin * 0.0.2      2016-11-08 Github (dpastoor/vancomycin@2436cb6)
#>  withr        1.0.2      2016-06-20 CRAN (R 3.3.0)                      
#>  xtable       1.8-2      2016-02-05 CRAN (R 3.3.0)                      
#>  yaml         2.1.13     2014-06-12 CRAN (R 3.3.0)
```
