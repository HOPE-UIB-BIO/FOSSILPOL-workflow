#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow
#
#                 Harmonise the pollen taxa
#
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon
#                         2021
#
#----------------------------------------------------------#

# Prepare all harmonisation tables and harmonise the raw counts


#----------------------------------------------------------#
# 1. Set up -----
#----------------------------------------------------------#

library(here)

# Load configuration
source(
  here::here("R/00_Config_file.R")
)

# set the current environment
current_env <- rlang::current_env()

RUtilpol::output_heading(
  msg = "Preparation of harmonisation tables and harmonisation of pollen taxa"
)


#----------------------------------------------------------#
# 2. Load data -----
#----------------------------------------------------------#

data_with_chronologies <-
  RUtilpol::get_latest_file(
    file_name = "data_with_chronologies",
    dir = paste0(
      data_storage_path, # [config_criteria]
      "/Data/Processed/Data_with_chronologies"
    )
  )

# test the presence of data
RUtilpol::check_if_loaded(
  file_name = "data_with_chronologies",
  env = current_env
)


#----------------------------------------------------------#
# 3. Get all harmonisation tables -----
#----------------------------------------------------------#

harmonisation_tables <-
  RFossilpol::harm_get_all_tables(
    data_source = data_with_chronologies,
    dir = data_storage_path # [config_criteria]
  )


#----------------------------------------------------------#
# 4. Harmonise data -----
#----------------------------------------------------------#

data_harmonised <-
  RFossilpol::harmonise_all_regions(
    data_source = data_with_chronologies,
    harmonisation_tables = harmonisation_tables,
    original_name = "taxon_name",
    harm_level = "level_1", # [USER] Change the levels if needed
    exclude_taxa = "delete",
    pollen_grain_test = TRUE # [USER] Turn FALSE to hide progress
  )


#----------------------------------------------------------#
# 5. Save the data  -----
#----------------------------------------------------------#

RUtilpol::save_latest_file(
  file_to_save = data_harmonised,
  dir = paste0(
    data_storage_path, # [config_criteria]
    "/Data/Processed/Data_harmonised"
  ),
  prefered_format = "rds",
  use_sha = TRUE
)
