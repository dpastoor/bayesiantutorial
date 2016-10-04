### eventually render site here automatically
## check at least lab-notebook and data exist, indicating reasonable
## likelihood in the correct directory
if (!all(dir.exists(c("lab-notebook", "data")))) {
  stop("are you sure your working directory is the top level project
       directory, it must be set there to render and move files correctly")
}
files_to_move <- list.files("lab-notebook/_book", full.names = T)

unlink("docs", recursive = T, force = T)
dir.create("docs", recursive = T)
copied <- file.copy(files_to_move, "docs", overwrite = T, recursive = T)

if(!all(copied)) {
  stop("could not copy all files, run each line of script manually to identify issue")
}
message("all files copied successfully")