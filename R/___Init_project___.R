#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow
#
#                     Project setup
#
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon
#                         2021
#
#----------------------------------------------------------#

# Script to prepare all necessary components of environment to run the Project.
#   Needs to be run only once


#----------------------------------------------------------#
# Step 0: Define package list and custom function -----
#----------------------------------------------------------#

# list of all CRAN packages
package_list <-
  c(
    "assertthat",
    "Bchron",
    "dplyr",
    "furrr",
    "future",
    "ggplot2",
    "grDevices",
    "here",
    "httr",
    "IntCal",
    "janitor",
    "lifecycle",
    "magrittr",
    "plyr",
    "purrr",
    "R.utils",
    "rcarbon",
    "readr",
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
    "utils"
  )

# define helper function
install_packages <-
  function(pkgs_list) {

    # install all packages in the lst from CRAN
    sapply(pkgs_list, utils::install.packages, character.only = TRUE)

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
  }


#----------------------------------------------------------#
# Step 1: Install 'renv' package -----
#----------------------------------------------------------#

utils::install.packages("renv")


#----------------------------------------------------------#
# Step 2: Deactivate 'renv' package -----
#----------------------------------------------------------#

# deactivate to make sure that packages are updated on the machine
renv::deactivate()


#----------------------------------------------------------#
# Step 3: Install packages to the machine
#----------------------------------------------------------#

install_packages(package_list)


#----------------------------------------------------------#
# Step 4: Activate 'renv' project
#----------------------------------------------------------#

renv::activate()


#----------------------------------------------------------#
# Step 5: Install packages to the project
#----------------------------------------------------------#

install_packages(package_list)


#----------------------------------------------------------#
# Step 6: Synchronize package versions with the project
#----------------------------------------------------------#

library(here)

# if there is no lock file present make a new snapshot
if (
  isFALSE("library_list.lock" %in% list.files(here::here("renv")))
) {
  renv::snapshot(
    lockfile = here::here("renv/library_list.lock")
  )
} else {
  renv::restore(
    lockfile = here::here("renv/library_list.lock")
  )
}


#----------------------------------------------------------#
# Step 7: Run the project
#----------------------------------------------------------#
