
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
NIDS <- 10000
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
                  ) %>% select(ID, everything())
```



```r
all_dosing <- for_dosing %>% group_by(ID) %>%
    nest() %>%
    mutate(dose = map(data, ~ dosing_6bin_pna_wt(.$AGE, .$WT))
           ) %>% unnest()
```

Dose for 8 days

```r
all_dosing <- all_dosing %>% 
  mutate(addl = as.integer(ceiling(24/II*8)))
```


```r
kable(head(all_dosing, n = 15))
```



 ID     WT     CRE     AGE   PMA     HT  SEX       CMT   EVID   TIME   DOSE   II   addl
---  -----  ------  ------  ----  -----  -------  ----  -----  -----  -----  ---  -----
  1   3.97   0.603   20.16   279   51.2  FEMALE      1      1      0   59.5    8     24
  2   3.17   0.559   28.23   299   55.5  MALE        1      1      0   47.5    8     24
  3   2.50   0.445   42.79   274   56.2  FEMALE      1      1      0   37.6    8     24
  4   2.14   0.901   19.31   249   46.0  FEMALE      1      1      0   32.1    8     24
  5   1.99   0.826   44.52   231   47.5  MALE        1      1      0   29.9   12     16
  6   3.74   0.404   45.53   299   51.3  MALE        1      1      0   56.1    8     24
  7   1.78   0.679   27.59   242   46.8  FEMALE      1      1      0   26.7   12     16
  8   4.17   0.524   16.24   302   52.3  MALE        1      1      0   62.6    8     24
  9   2.33   0.473    9.13   241   43.8  MALE        1      1      0   34.9    8     24
 10   3.07   0.609   26.87   287   51.3  MALE        1      1      0   46.0    8     24
 11   2.99   0.823   17.71   241   51.9  MALE        1      1      0   44.8    8     24
 12   1.54   0.279   23.67   222   43.0  FEMALE      1      1      0   23.1   12     16
 13   4.62   0.315   14.58   322   56.2  MALE        1      1      0   69.3    8     24
 14   1.01   0.330   20.18   205   42.0  FEMALE      1      1      0   15.2   24      8
 15   3.58   0.624   36.40   275   56.0  MALE        1      1      0   53.7    8     24


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
#>  package    * version    date       source                              
#>  assertthat   0.1        2013-12-06 CRAN (R 3.3.2)                      
#>  backports    1.0.4      2016-10-24 CRAN (R 3.3.2)                      
#>  bookdown     0.2        2016-11-12 CRAN (R 3.3.2)                      
#>  codetools    0.2-15     2016-10-05 CRAN (R 3.3.2)                      
#>  colorspace   1.2-7      2016-10-11 CRAN (R 3.3.2)                      
#>  DBI          0.5-1      2016-09-10 CRAN (R 3.3.2)                      
#>  devtools     1.12.0     2016-06-24 CRAN (R 3.3.2)                      
#>  digest       0.6.10     2016-08-02 CRAN (R 3.3.2)                      
#>  dplyr      * 0.5.0      2016-06-24 CRAN (R 3.3.2)                      
#>  evaluate     0.10       2016-10-11 CRAN (R 3.3.2)                      
#>  ggplot2    * 2.1.0.9001 2016-11-07 Github (hadley/ggplot2@70c3d69)     
#>  gtable       0.2.0      2016-02-26 CRAN (R 3.3.2)                      
#>  highr        0.6        2016-05-09 CRAN (R 3.3.2)                      
#>  htmltools    0.3.5      2016-03-21 CRAN (R 3.3.2)                      
#>  httpuv       1.3.3      2015-08-04 CRAN (R 3.3.2)                      
#>  knitr      * 1.15       2016-11-09 CRAN (R 3.3.2)                      
#>  lazyeval     0.2.0      2016-06-12 CRAN (R 3.3.2)                      
#>  magrittr   * 1.5        2014-11-22 CRAN (R 3.3.2)                      
#>  memoise      1.0.0      2016-01-29 CRAN (R 3.3.2)                      
#>  mime         0.5        2016-07-07 CRAN (R 3.3.2)                      
#>  miniUI       0.1.1      2016-01-15 CRAN (R 3.3.2)                      
#>  munsell      0.4.3      2016-02-13 CRAN (R 3.3.2)                      
#>  PKPDmisc   * 0.4.4.9000 2016-11-02 Github (dpastoor/PKPDmisc@beae2a6)  
#>  plyr         1.8.4      2016-06-08 CRAN (R 3.3.2)                      
#>  purrr      * 0.2.2      2016-06-18 CRAN (R 3.3.2)                      
#>  R6           2.2.0      2016-10-05 CRAN (R 3.3.2)                      
#>  Rcpp         0.12.8     2016-11-17 CRAN (R 3.3.2)                      
#>  readr      * 1.0.0      2016-08-03 CRAN (R 3.3.2)                      
#>  rmarkdown    1.2        2016-11-21 CRAN (R 3.3.2)                      
#>  rprojroot    1.1        2016-10-29 CRAN (R 3.3.2)                      
#>  scales       0.4.0.9003 2016-11-07 Github (hadley/scales@d58d83a)      
#>  shiny        0.14.2     2016-11-01 CRAN (R 3.3.2)                      
#>  stringi      1.1.2      2016-10-01 CRAN (R 3.3.2)                      
#>  stringr      1.1.0      2016-08-19 CRAN (R 3.3.2)                      
#>  tibble     * 1.2        2016-08-26 CRAN (R 3.3.2)                      
#>  tidyr      * 0.6.0      2016-08-12 CRAN (R 3.3.2)                      
#>  tidyverse  * 1.0.0      2016-09-09 CRAN (R 3.3.2)                      
#>  vancomycin * 0.0.2      2016-11-08 Github (dpastoor/vancomycin@2436cb6)
#>  withr        1.0.2      2016-06-20 CRAN (R 3.3.2)                      
#>  xtable       1.8-2      2016-02-05 CRAN (R 3.3.2)                      
#>  yaml         2.1.13     2014-06-12 CRAN (R 3.3.2)
```
