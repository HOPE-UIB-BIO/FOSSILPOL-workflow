#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow
#
#         Download pollen database from Neotoma
#
#
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon
#                         2021
#
#----------------------------------------------------------#

#  Download the pollen sequences from Neotoma API

#----------------------------------------------------------#
# 1. Set up  -----
#----------------------------------------------------------#

library(here)

# Load configuration
source(
  here::here("R/00_Config_file.R")
)

RUtilpol::output_heading(
  msg = "Start to download Neotoma files"
)


#----------------------------------------------------------#
# 2. Get sequences from Neotoma pollen database -----
#----------------------------------------------------------#

allds <-
  RFossilpol::proc_neo_get_all_neotoma_datasets(
    dataset_type, # [config_criteria]
    long_min, # [config_criteria]
    long_max, # [config_criteria]
    lat_min, # [config_criteria]
    lat_max, # [config_criteria]
    loc = NULL # [USER]
  )


#----------------------------------------------------------#
# 2. Download sequences -----
#----------------------------------------------------------#

neotoma_download <-
  RFossilpol::proc_neo_download_sequences(
    allds = allds,
    dir = paste0(
      data_storage_path, # [config_criteria]
      "/Data/Input/Neotoma_download"
    )
  )

#----------------------------------------------------------#
# 3. Save -----
#----------------------------------------------------------#

RUtilpol::output_comment(
  msg = "Saving 'neotoma_download'"
)

RUtilpol::save_latest_file(
  object_to_save = neotoma_download,
  dir = paste0(
    data_storage_path, # [config_criteria]
    "/Data/Input/Neotoma_download"
  ),
  prefered_format = "rds",
  use_sha = TRUE
)
