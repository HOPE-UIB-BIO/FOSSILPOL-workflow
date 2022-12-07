#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow
#
#                 Extract other data
#
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon
#                         2021
#
#----------------------------------------------------------#

#  Source other data and filter the sequences in a way that they
#   are comparable with Neotoma

#----------------------------------------------------------#
# 1. Set up  -----
#----------------------------------------------------------#

library(here)

# Load configuration
source(
  here::here(
    "R/00_Config_file.R"
  )
)

RUtilpol::output_heading(
  msg = "Starting combining other data sources"
)


#----------------------------------------------------------#
# 2. Load and other datasets  -----
#----------------------------------------------------------#

# load all other dataset
# load all other dataset
other_data_assembly <-
  RFossilpol::import_datasets_from_folder(
    # path to the folder with other datasets in .xlsx format (prepared using
    #   the template provided)
    dir_files = paste0(
      data_storage_path, # [config_criteria]
      "/Data/Input/Other/"
    ), # [USER]
    dir = data_storage_path, # [config_criteria]
    suffix = "other"
  ) %>% # [USER] user can specify the suffix of the data
  # e.g. the region or source of data
  dplyr::mutate(
    source_of_data = "personal_data",
    data_publicity = "restricted",
    pollen_percentage = FALSE
  )

# alternatively user can specify direction to the .rds file
# other_data_assembly <-
#   c()

#----------------------------------------------------------#
# 3. Process other datasets  -----
#----------------------------------------------------------#

other_data_prepared <-
  RFossilpol::proc_priv_prepare(
    other_data_assembly,
    data_storage_path, # [config_criteria]
    min_n_levels, # [config_criteria]
    long_min, # [config_criteria]
    long_max, # [config_criteria]
    lat_min, # [config_criteria]
    lat_max, # [config_criteria]
    alt_min, # [config_criteria]
    alt_max # [config_criteria]
  )

#----------------------------------------------------------#
# 4. Save the tibble of the combined other datasets  -----
#----------------------------------------------------------#

RUtilpol::output_heading(
  msg = "Saving 'other_data_prepared'",
  size = "h2"
)

RUtilpol::save_latest_file(
  object_to_save = other_data_prepared,
  dir = paste0(
    data_storage_path, # [config_criteria]
    "/Data/Processed/Other"
  ),
  prefered_format = "rds",
  use_sha = TRUE
)
