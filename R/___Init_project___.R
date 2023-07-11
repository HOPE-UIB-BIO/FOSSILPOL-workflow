#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow
#
#                     Project setup
#
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon
#                         2023
#
#----------------------------------------------------------#

# Script to prepare all components of the environment to run the Project.
#   Needs to be run only once

#----------------------------------------------------------#
# Step 0: Install critical packages -----
#----------------------------------------------------------#

# {renv} for package management
utils::install.packages("renv")

# {here} for file navigation
utils::install.packages("here")

#----------------------------------------------------------#
# Step 1: Synchronize package versions with the project -----
#----------------------------------------------------------#

library(here)

# If there is no lock file present make a new snapshot
if (
  isTRUE("library_list.lock" %in% list.files(here::here("renv")))
) {
  cat("The project already has a lockfile. Restoring packages", "\n")

  renv::restore(
    lockfile = here::here("renv/library_list.lock")
  )

  cat("Set up completed. You can continute to run the project", "\n")

  cat("Do NOT run the rest of this script", "\n")
} else {
  cat("The project seems to be new (no lockfile)", "\n")

  cat("Continue with this script", "\n")
}

#----------------------------------------------------------#
# Step 2: Activate 'renv' project -----
#----------------------------------------------------------#

# NOTE: The R may ask the User to restart the session (R).
#   After that, continue with the next step

renv::activate()


#----------------------------------------------------------#
# Step 3: Install packages to the project -----
#----------------------------------------------------------#

# install all packages in the lst from CRAN
sapply(
  c(
    "assertthat",
    "Bchron",
    "dplyr",
    "forcats",
    "furrr",
    "future",
    "ggplot2",
    "ggpubr",
    "grDevices",
    "here",
    "httr",
    "IntCal",
    "janitor",
    "knitr",
    "lifecycle",
    "magrittr",
    "methods",
    "neotoma2",
    "purrr",
    "qs",
    "raster",
    "rcarbon",
    "readr",
    "readxl",
    "remotes",
    "rioja",
    "rlang",
    "sf",
    "sp",
    "stats",
    "stringr",
    "tibble",
    "tidyr",
    "tidyselect",
    "tidyverse",
    "usethis",
    "utils",
    "waldo",
    "zip"
  ),
  utils::install.packages,
  character.only = TRUE
)

# install RUtilpol from GitHub
remotes::install_github(
  repo = "HOPE-UIB-BIO/R-Utilpol-package",
  ref = "HEAD",
  quiet = FALSE,
  upgrade = "ask"
)

# install RFossilpol from GitHub
remotes::install_github(
  repo = "HOPE-UIB-BIO/R-Fossilpol-package@*release",
  quiet = FALSE,
  upgrade = "ask"
)

#----------------------------------------------------------#
# Step 4: Save versions of packages -----
#----------------------------------------------------------#

renv::snapshot(
  lockfile = here::here("renv/library_list.lock")
)

cat("Set up completed. You can continute to run the project", "\n")
