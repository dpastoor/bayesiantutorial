library(overseer)

## note, if this script is going to be run interactively, make sure to set the
## wd to the same location as the script itself
## setwd(file.path(getwd()," models"))
models <- Overseer$new()


models$add_model_file("vanc_stockmann")

