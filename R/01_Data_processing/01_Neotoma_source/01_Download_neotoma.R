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
  here::here("R/00_Config_file.R"))

fossilpol::util_output_message(
  msg = "Start to download Neotoma files")


#----------------------------------------------------------#
# 2. Download the Neotoma pollen database -----
#----------------------------------------------------------#

allds <- 
  fossilpol::proc_neo_get_all_neotoma_datasets(
    dataset_type, #[config_criteria]
    long_min, #[config_criteria]
    long_max, #[config_criteria]
    lat_min, #[config_criteria]
    lat_max #[config_criteria]
  ) 

# Download all sequences
neotoma_download <-
  fossilpol::proc_neo_download_sequences(allds)


#----------------------------------------------------------#
# 2. Save the Neotoma pollen database -----
#----------------------------------------------------------#

fossilpol::util_output_comment(
  msg = "Saving 'neotoma_download'")

fossilpol::util_save_if_latests(
  file_name = "neotoma_download",
  dir = paste0(data_storage_path, #[config_criteria]
               "/Data/Input/Neotoma_download"),
  prefered_format = "rds")
