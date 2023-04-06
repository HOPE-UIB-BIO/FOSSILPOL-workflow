#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow
#
#                 Extraction of samples
#
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon
#                         2023
#
#----------------------------------------------------------#

#  Extract samples from Neotoma JSON structure and extract the information
#   about authors of datasets

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
  msg = "Processing Neotoma files"
)


#----------------------------------------------------------#
# 2. Load latest data  -----
#----------------------------------------------------------#

RUtilpol::output_heading(
  msg = "Loading Neotoma file",
  size = "h2"
)

# load the data
neotoma_download <-
  RUtilpol::get_latest_file(
    file_name = "neotoma_download",
    dir = paste0(
      data_storage_path, # [config_criteria]
      "/Data/Input/Neotoma_download"
    )
  )

# test the presence of data
RUtilpol::check_if_loaded(
  file_name = "neotoma_download",
  env = current_env
)


#----------------------------------------------------------#
# 2.  Extract the meta information and individual samples -----
#----------------------------------------------------------#

neotoma_meta_samples <-
  RFossilpol::proc_neo_get_metadata_with_samples(
    neotoma_download,
    long_min, # [config_criteria]
    long_max, # [config_criteria]
    lat_min, # [config_criteria]
    lat_max, # [config_criteria]
    alt_min, # [config_criteria]
    alt_max # [config_criteria]
  )


#----------------------------------------------------------#
# 3. Authors of datasets and project database -----
#----------------------------------------------------------#

# Extract information about dataset authors
neotoma_sites_authors <-
  RFossilpol::proc_neo_get_authors(
    neotoma_download = neotoma_download,
    dataset_ids = neotoma_meta_samples$dataset_id,
    download_new = TRUE,
    dir = data_storage_path # [config_criteria]
  )

# Update the project database
RFossilpol::proc_neo_update_project_database(
  neotoma_sites_authors = neotoma_sites_authors,
  neotoma_meta_samples = neotoma_meta_samples,
  dir = data_storage_path # [config_criteria]
)


#----------------------------------------------------------#
# 4. Save the data -----
#----------------------------------------------------------#

RUtilpol::output_comment(
  msg = "Saving outputs"
)

RUtilpol::save_latest_file(
  object_to_save = neotoma_meta_samples,
  dir = paste0(
    data_storage_path, # [config_criteria]
    "/Data/Processed/Neotoma_processed/Neotoma_meta"
  ),
  prefered_format = "rds",
  use_sha = TRUE
)
