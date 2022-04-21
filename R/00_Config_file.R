#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow 
#
#                     Config file
#                 
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon 
#                         2021
#
#----------------------------------------------------------#

# Configuration script with the variables that should be consistent throughout 
#   the whole repo. It loads packages, defines important variables, 
#   authorises the user, and saves config file.

# Version of the Workflow
workflow_version <- 
  "0.0.1" 

# set the current environment
current_env <- environment()

#----------------------------------------------------------#
# 1. Load packages -----
#----------------------------------------------------------#

if(!exists("update_repo_packages", envir = current_env)){
  update_repo_packages <- TRUE
}

if(update_repo_packages == TRUE){
  
  # install RFossilpol from github
  if (!exists("already_installed_RFossilpol", envir = current_env)){
    already_installed_RFossilpol <- FALSE
  }
  
  if(already_installed_RFossilpol == FALSE){
    devtools::install_github("HOPE-UIB-BIO/R-Fossilpol-package",
                             quiet = FALSE,
                             upgrade = FALSE)
    already_installed_RFossilpol <- TRUE
  }
  
  if (!exists("already_synch", envir = current_env)){
    already_synch <- FALSE
  }
  
  if(already_synch == FALSE){
    library(here)
    # synchronise the package versions
    renv::restore(lockfile = here::here( "renv/library_list.lock"))
    already_synch <- TRUE
    
    # save snapshot of package versions
    # renv::snapshot(lockfile =  "renv/library_list.lock")  # do only for update
  }
}

# define packages
package_list <- 
  c(
    "devtools",
    "Bchron",
    "RFossilpol",
    "here",     
    "tidyverse"
  )

# load all packages
sapply(package_list, library, character.only = TRUE)


#----------------------------------------------------------#
# 2. Define space -----
#----------------------------------------------------------#

current_date <- Sys.Date()

# project directory is set up by 'here' package, Adjust if needed 
current_dir <- here::here()


#----------------------------------------------------------#
# 3. Load functions -----
#----------------------------------------------------------#

# get vector of general functions
fun_list <- 
  list.files(
    path = "R/Functions/",
    pattern = "*.R",
    recursive = TRUE) 

# source them
sapply(
  paste0("R/Functions/", fun_list, sep = ""),
  source)


#----------------------------------------------------------#
# 4. Define the directories (for big files) -----
#----------------------------------------------------------#

# Define the directory (external) for storing big data files
#   Default is in the current project
data_storage_path <- current_dir # [USER]

# create all essential folders 
RFossilpol::util_make_datastorage_folders(
  dir = data_storage_path #[config_criteria]
  )


#--------------------------------------------------#
# 4.1  Project dataset database -----
#--------------------------------------------------#

# check the presence of dataset database and create it if necessary
if("project_dataset_database.rds" %in%
   list.files(
     paste0(
       data_storage_path, #[config_criteria]
       "/Data/Personal_database_storage") ) == FALSE){
  
  project_dataset_database <-
    methods::new("proj_db_class")
  
  readr::write_rds(
    project_dataset_database,
    paste0(data_storage_path, #[config_criteria]
           "/Data/Personal_database_storage",
           "/project_dataset_database.rds" ),
    compress = "gz")
  
}


#----------------------------------------------------------#
# 5. Define variables -----
#----------------------------------------------------------#

#--------------------------------------------------#
# 5.1. Define individual run -----
#--------------------------------------------------#

# Include/exclude Neotoma download in run
dataset_type <- 'pollen'

# Selected variable element (proxy)
sel_var_element <- "pollen"

# geographical limitation of data
long_min <- -180 # [USER]
long_max <- 180 # [USER]
lat_min <- -90 # [USER]
lat_max <- 90 # [USER]
alt_min <- NA # [USER]
alt_max <- NA # [USER]

neotoma_new_download <- TRUE

# define access to private datasets
private_data <- FALSE # [USER]
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
    type = c("Varve years BP",
             "Calibrated radiocarbon years BP",
             "Calendar years BP",
             "Radiocarbon years BP",
             "Calendar years AD/BC",
             NA))


#--------------------------------------------------#
# 5.5. Age depth models  ----- 
#--------------------------------------------------#

# Chronology needs to have at least X control points
min_n_of_control_points <- 2 # [USER]

# If thickness of control point is missing, assign X cm
default_thickness <- 1 # [USER]

# If age error of control point is missing, assign X yr
default_error <- 100 # [USER]

# maximum accepted age error of chron.control point
max_age_error <- 3000 # [USER]

# depth at which "Guess" is accepted as chronology control point
guess_depth <- 10 # [USER]

# bchron settings
number_of_cores <- parallel::detectCores() - 1
batch_size <-  number_of_cores * 3
set_seed <- 1234

default_iteration <- 10e3
default_burn <- 2000
default_thin <- 8 # [USER]
iteration_multiplier <- 5 # [USER]


#--------------------------------------------------#
# 5.6. Level filtering criteria  ----- 
#--------------------------------------------------#

# criteria to filter out levels and sequences

#----------------------------------------#

# Pollen sums 
filter_by_pollen_sum <- TRUE # [USER]

# each level at least X individual pollen gains
min_n_grains <- 0 # [USER]
# ideal number of counts
target_n_grains <- 100 # [USER]
# threshold of number of samples with ideal counts
percentage_samples <- 0 # [USER]

#----------------------------------------#

# Age limits
#   Note that the actual ages have to specified per region, defined during the
#   process of Workflow  
filter_by_age_limit <- TRUE # [USER]

#----------------------------------------#

# Maximum extrapolation
filter_by_extrapolation <- TRUE # [USER]

# how much age can be extrapolated beyond the oldest chronology control point
maximum_age_extrapolation <- Inf # [USER]

#----------------------------------------#

# Beyond period of interest
#   Note that the actual ages have to specified per region, defined during the
#   process of Workflow 
filter_by_interest_region <- TRUE # [USER]

#----------------------------------------#

# Number of levels
filter_by_number_of_levels <- TRUE # [USER]

# at least X number levels within period of interest 
min_n_levels <-  3  

#----------------------------------------#

# Additional setting

# Should 95th age quantile be used for data filtration?
#   This will result in more stable data assembly between different result 
#   of AD modelling BUT require additional data preparation before analytical
#   part
use_age_quantiles <- FALSE # [USER]

# Should all data filtration omit one additional level in the old period?
#   This will result of "bookend" level, which can help to provide anchor 
#   information after the period of interest
use_bookend_level <- FALSE # [USER]


#----------------------------------------------------------#
# 7. Graphical option -----
#----------------------------------------------------------#

# set ggplot output
ggplot2::theme_set(ggplot2::theme_classic())

# define general
text_size = 16 # [USER]
line_size = 0.1 # [USER]
point_size = 3 # [USER]

# define output sizes
image_width <- 30 # [USER]
image_height <- 15 # [USER]
image_units <- "cm" # [USER]
image_dpi <- 300 # [USER]

# define pallets

# define common colours


#----------------------------------------------------------#
# 7. Save current config setting -----
#----------------------------------------------------------#

current_setting <- RFossilpol::util_extract_config_data()

