#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow
#
#        Extract chronologies and control points
#
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon
#                         2021
#
#----------------------------------------------------------#

# Extract preferred chronology and get corresponding
# table with chronology control points

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

RFossilpol::util_output_message(
  msg = "Starting extracting Neotoma chron.control"
)

#----------------------------------------------------------#
# 2. Load latest data  -----
#----------------------------------------------------------#

RFossilpol::util_output_comment(
  msg = "Loading Neotoma download file"
)

neotoma_download <-
  RFossilpol::util_load_latest_file(
    file_name = "neotoma_download",
    dir = paste0(
      data_storage_path, # [config_criteria]
      "/Data/Input/Neotoma_download"
    )
  )

# test the presence of data
RFossilpol::util_check_if_loaded(
  file_name = "neotoma_download",
  env = current_env
)

RFossilpol::util_output_comment(
  msg = "Loading Neotoma dep.env file"
)

neotoma_meta_samples_dep_envt_filtered <-
  RFossilpol::util_load_latest_file(
    file_name = "neotoma_meta_samples_dep_envt_filtered",
    dir = paste0(
      data_storage_path, # [config_criteria]
      "/Data/Processed/Neotoma_processed/Neotoma_dep_env"
    )
  )

# test the presence of data
RFossilpol::util_check_if_loaded(
  file_name = "neotoma_meta_samples_dep_envt_filtered",
  env = current_env
)


#----------------------------------------------------------#
# 3. Get relevant chronologies and their control points -----
#----------------------------------------------------------#

chroncontrol_tables <-
  RFossilpol::proc_neo_get_chronologies(
    neotoma_download,
    chron_order, # [config_criteria]
    min_n_of_control_points # [config_criteria]
  )


#----------------------------------------------------------#
# 4. Merge it with the data  -----
#----------------------------------------------------------#

neotoma_meta_chron_control <-
  RFossilpol::proc_neo_add_chronologies(
    neotoma_meta_samples_dep_envt_filtered,
    chroncontrol_tables
  )


#----------------------------------------------------------#
# 5. Save  -----
#----------------------------------------------------------#

RFossilpol::util_output_comment(
  msg = "Saving"
)

RFossilpol::util_save_if_latests(
  file_name = "neotoma_meta_chron_control",
  dir = paste0(
    data_storage_path, # [config_criteria]
    "/Data/Processed/Neotoma_processed/Neotoma_chron_control"
  ),
  prefered_format = "rds"
)
