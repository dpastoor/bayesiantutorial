library(overseer)

## note, if this script is going to be run interactively, make sure to set the
## wd to the same location as the script itself
## setwd(file.path(getwd()," models"))
# print(interactive())
# print(getwd())
# if (interactive()) {
#   if (!file.exists("vanco_stockmann.cpp")) {
#     stop("make sure the directory is set to the models directory before running interactively,
#          to make sure the relative paths will be the same as when sourcing")
#   }
# }

models <- Overseer$new()


models$add_model_file("vanc_stockmann")

models