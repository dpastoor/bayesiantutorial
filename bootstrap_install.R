# must source if haven't installed the desc package from r-pkgs/desc on github
if (!requireNamespace("desc", quietly = T)) {
  message("missing package desc, installing directly from github")
  source("https://raw.githubusercontent.com/MangoTheCat/remotes/master/install-github.R")$value("metacran/desc")
}
if (!(requireNamespace("dplyr", quietly = T) && requireNamespace("purrr", quietly = T))) {
  message("missing packages dplyr or purrr, installing now from CRAN")
  install.packages("tidyverse")
}

library(desc, quietly = T)
library(purrr, quietly = T)
library(dplyr, quietly = T)

desc <- description$new() 
  
packages <- desc$get_deps()$package
packages <- packages[packages != "R"]
missing_packages <- packages %>% 
  map_lgl(~ requireNamespace(., quietly = T)) %>%
  map2(packages, function(.x, .y) {
    if (!.x) {
      return(.y)
    }
    return(NULL)
  }) %>% unlist

if (length(missing_packages)) {
  message(paste0("you are missing packages: ", missing_packages, collapse = ", "))
}
remote_sources <- desc$get_remotes()

.package = "vancomycin"
where_to_download_probably <- function(.package, remote_sources) {
  is_in_remote <- grepl(.package, remote_sources)
  if (any(is_in_remote)) {
     message("devtools::install_github(", remote_sources[is_in_remote], ")")
  } else {
    message("install.packages(", .package, ")")
  }
  return(TRUE)
}
message("packages may be installed via: ")
where_to_install <- missing_packages %>% 
  map(where_to_download_probably, remote_sources)
  

