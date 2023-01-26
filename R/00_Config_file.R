#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow
#
#                     Config file
#
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon
#                         2023
#
#----------------------------------------------------------#

# Configuration script with the variables that should be consistent throughout
#   the whole repo. It loads packages, defines important variables,
#   authorises the user, and saves the config file.
# Points that require the user’s attention are flagged by "[USER]" - flag,
#  meaning that these are criteria that need to be checked by the user

# Version of the Workflow
workflow_version <-
  "0.0.2"

# Set the current environment
current_env <- environment()

#----------------------------------------------------------#
# 1. Load packages -----
#----------------------------------------------------------#

if (
  isFALSE(
    exists("already_synch", envir = current_env)
  )
) {
  already_synch <- FALSE
}

if (
  isFALSE(already_synch)
) {
  library(here)
  # Synchronise the package versions
  renv::restore(
    lockfile = here::here("renv/library_list.lock")
  )
  already_synch <- TRUE

  # Save snapshot of package versions
  # renv::snapshot(lockfile =  "renv/library_list.lock")  # do only for update
}

# Define packages
package_list <-
  c(
    "RFossilpol",
    "RUtilpol",
    "here",
    "tidyverse"
  )

# Attach all packages
sapply(package_list, library, character.only = TRUE)


#----------------------------------------------------------#
# 2. Current date and working directory -----
#----------------------------------------------------------#

current_date <- Sys.Date()

# Project directory is set up by the {here} package, Adjust if needed
current_dir <- here::here()

# Define the directory (external) for storing big data files
#   Default is in the current project
data_storage_path <- current_dir # [USER]

# Create all essential folders
RFossilpol::util_make_datastorage_folders(
  dir = data_storage_path # [config_criteria]
)

#----------------------------------------------------------#
# 3. Load functions -----
#----------------------------------------------------------#

# Get a vector of general functions
fun_list <-
  list.files(
    path = "R/Functions/",
    pattern = "*.R",
    recursive = TRUE
  )

# Load the function into the global environment
sapply(
  paste0("R/Functions/", fun_list, sep = ""),
  source
)


#--------------------------------------------------#
# 4. Project dataset database -----
#--------------------------------------------------#

# Check the presence of a dataset database and create it if necessary
if (
  isFALSE(
    "project_dataset_database.rds" %in%
      list.files(
        paste0(
          data_storage_path, # [config_criteria]
          "/Data/Personal_database_storage"
        )
      )
  )
) {
  project_dataset_database <-
    RFossilpol:::proj_db_class()

  readr::write_rds(
    project_dataset_database,
    paste0(
      data_storage_path, # [config_criteria]
      "/Data/Personal_database_storage",
      "/project_dataset_database.rds"
    ),
    compress = "gz"
  )
}


#----------------------------------------------------------#
# 5. Define variables -----
#----------------------------------------------------------#

#--------------------------------------------------#
# 5.1. Define individual run -----
#--------------------------------------------------#

# Include/exclude Neotoma download in run
dataset_type <- "pollen"

# Selected variable element (proxy)
sel_var_element <- "pollen"

# Set geographical boundaries
long_min <- -180 # [USER]
long_max <- 180 # [USER]
lat_min <- -90 # [USER]
lat_max <- 90 # [USER]
alt_min <- NA # [USER]
alt_max <- NA # [USER]

neotoma_new_download <- TRUE

# Define access to datasets from other sources than Neotoma
use_other_datasource <- FALSE # [USER]
detect_duplicates <- TRUE # [USER]

# Include/exclude age modelling in run
recalib_AD_models <- TRUE # [USER]
calc_AD_models_denovo <- FALSE # [USER]
predict_ages_denovo <- FALSE # [USER]

# Select the final variables
select_final_variables <- TRUE # [USER]


#--------------------------------------------------#
# 5.2. Chronology order  -----
#--------------------------------------------------#

# Selected and preferred order of age type of existing chronologies in Neotoma
chron_order <-
  tibble::tibble(
    order = seq(1, 6),
    type = c(
      "Varve years BP",
      "Calibrated radiocarbon years BP",
      "Calendar years BP",
      "Radiocarbon years BP",
      "Calendar years AD/BC",
      NA
    )
  )


#--------------------------------------------------#
# 5.5. Age depth models  -----
#--------------------------------------------------#

# Chronology needs to have at least X control points [example: X=2]
min_n_of_control_points <- 2 # [USER]

# If the thickness of a control point is missing, assign X cm [example: X=1]
default_thickness <- 1 # [USER]

# If the age error of a control point is missing, assign X yr [example: X=100]
default_error <- 100 # [USER]

# Maximum accepted age error of chron.control point [example: X=3000]
max_age_error <- 3000 # [USER]

# Depth at which "Guess" is accepted as a chronology control
#   point [example: X=10]
guess_depth <- 10 # [USER]

# Bchron settings
number_of_cores <- parallel::detectCores() - 1
batch_size <- number_of_cores * 3
set_seed <- 1234

default_iteration <- 10e3
default_burn <- 2000
default_thin <- 8 # [USER]
iteration_multiplier <- 5 # [USER]


#--------------------------------------------------#
# 5.6. Filtering criteria -----
#--------------------------------------------------#

# Criteria to filter out stratigraphic levels and pollen records

#----------------------------------------#

# Pollen sums
filter_by_pollen_sum <- TRUE # [USER]

# Each stratigraphic level of at least X individual pollen gains [example: X=0]
min_n_grains <- 0 # [USER]
# Ideal number of counts
target_n_grains <- 100 # [USER]
# Threshold of number of samples with ideal counts
percentage_samples <- 0 # [USER]

#----------------------------------------#

# Age limits
#   Note that the actual ages have to be specified per region, defined during
# the process of Workflow
filter_by_age_limit <- TRUE # [USER]

#----------------------------------------#

# Maximum extrapolation
filter_by_extrapolation <- TRUE # [USER]

# How much age can be extrapolated beyond the oldest chronology control point?
maximum_age_extrapolation <- Inf # [USER]

#----------------------------------------#

# Beyond the period of interest
#   Note that the actual ages have to be specified per region, defined during
# the process of Workflow
filter_by_interest_region <- TRUE # [USER]

#----------------------------------------#

# Number of stratigraphic levels
filter_by_number_of_levels <- TRUE # [USER]

# St least X number stratigraphic levels within the period
#   of interest [example: X=3]
min_n_levels <- 3

#----------------------------------------#

# Additional setting

# Should the 95th age quantile be used for data filtration?
# If FALSE (default), the estimated age will be used for all checks about the
#   age of a stratigraphic level. However, if TRUE, then the 95th age quantile
#   will be used.
# This will result in more stable data assembly between different results
#   of age-depth modelling BUT require additional data preparation before
#   analytical part.
use_age_quantiles <- FALSE # [USER]

# Should all data filtration omit one additional stratigraphic level in
#   the old period?
# If TRUE, all filtering will proceed normally but one additional "bookend"
#   stratigraphic level will be always kept.
# A "bookend" stratigraphic level is a subsequential stratigraphic level
#   older than the oldest stratigraphic level that passed the filtration.
# A "bookend" can help provide anchor information older than the period of
#     interest.
use_bookend_level <- FALSE # [USER]


#----------------------------------------------------------#
# 6. Set graphical options -----
#----------------------------------------------------------#

# Set ggplot output
ggplot2::theme_set(
  ggplot2::theme_classic()
)

# Define general
text_size <- 16 # [USER]
line_size <- 0.1 # [USER]
point_size <- 3 # [USER]

# Define output sizes
image_width <- 30 # [USER]
image_height <- 15 # [USER]
image_units <- "cm" # [USER]
image_dpi <- 300 # [USER]

# Define pallets

# Define common colours


#----------------------------------------------------------#
# 7. Save current config setting -----
#----------------------------------------------------------#

current_setting <-
  RFossilpol::util_extract_config_data()
