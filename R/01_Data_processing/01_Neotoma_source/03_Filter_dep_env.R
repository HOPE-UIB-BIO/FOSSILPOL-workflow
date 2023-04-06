#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow
#
#         Filtering based on depositional environment
#
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon
#                         2023
#
#----------------------------------------------------------#

# Get data of depositional environment and filter out by selected types

#----------------------------------------------------------#
# 1. Set up  -----
#----------------------------------------------------------#

library(here)

# Load configuration
source(
  here::here("R/00_Config_file.R")
)

# set the current environment
current_env <- rlang::current_env()

RUtilpol::output_heading(
  msg = "Starting processing depositional environment"
)

#----------------------------------------------------------#
# 2. Load Neotoma files -----
#----------------------------------------------------------#

# load the data
neotoma_meta_samples <-
  RUtilpol::get_latest_file(
    file_name = "neotoma_meta_samples",
    dir = paste0(
      data_storage_path, # [config_criteria]
      "/Data/Processed/Neotoma_processed/Neotoma_meta"
    )
  )

# test the presence of data
RUtilpol::check_if_loaded(
  file_name = "neotoma_meta_samples",
  env = current_env
)


#----------------------------------------------------------#
# 3. Filter data by the selection fo depositional environments -----
#----------------------------------------------------------#

neotoma_meta_samples_dep_envt_filtered <-
  RFossilpol::proc_neo_filter_by_dep_env(
    neotoma_meta_samples,
    data_storage_path # [config_criteria]
  )


#----------------------------------------------------------#
# 4. Save the data  -----
#----------------------------------------------------------#

RUtilpol::output_comment(
  msg = "Saving"
)

RUtilpol::save_latest_file(
  object_to_save = neotoma_meta_samples_dep_envt_filtered,
  dir = paste0(
    data_storage_path, # [config_criteria]
    "/Data/Processed/Neotoma_processed/Neotoma_dep_env"
  ),
  prefered_format = "rds",
  use_sha = TRUE
)
