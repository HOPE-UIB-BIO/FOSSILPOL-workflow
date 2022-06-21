#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow
#
#                 Extract private data
#
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon
#                         2021
#
#----------------------------------------------------------#

#  Source private data and filter the sequences in a way that they
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

RFossilpol::util_output_message(
  msg = "Starting combining private data sources"
)


#----------------------------------------------------------#
# 2. Load and private datasets  -----
#----------------------------------------------------------#

# load all private dataset
# load all private dataset
private_data_assembly <-
  RFossilpol::import_datasets_from_folder(
    # path to the folder with private datasets in .xlsx format (prepared using
    #   the template provided)
    dir_files = paste0(
      data_storage_path, # [config_criteria]
      "/Data/Input/Private/"
    ), # [USER]
    dir = data_storage_path, # [config_criteria]
    suffix = "private"
  ) %>% # [USER] user can specify the suffix of the data
  # e.g. the region or source of data
  dplyr::mutate(
    source_of_data = "personal_data",
    data_publicity = "private",
    pollen_percentage = FALSE
  )

# alternatively user can specify direction to the .rds file
# private_data_assembly <-
#   c()

#----------------------------------------------------------#
# 3. Process private datasets  -----
#----------------------------------------------------------#

private_data_prepared <-
  RFossilpol::proc_priv_prepare(
    private_data_assembly,
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
# 4. Save the tibble of the combined private datasets  -----
#----------------------------------------------------------#

RFossilpol::util_output_message(
  msg = "Saving 'private_data_prepared'"
)

RFossilpol::util_save_if_latests(
  file_name = "private_data_prepared",
  dir = paste0(
    data_storage_path, # [config_criteria]
    "/Data/Processed/Private"
  ),
  prefered_format = "rds"
)
