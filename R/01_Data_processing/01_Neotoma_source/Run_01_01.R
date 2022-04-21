#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow 
#
#           Run all Neotoma data preparation
#                 
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon 
#                         2021
#
#----------------------------------------------------------#

# Run all scripts in `/R/01_Data_processing/01_Neotoma_source/`
#   Download Neotoma pollen database, create tibble, 
#   apply criteria, add chronology control info, and raw sample info

#----------------------------------------------------------#
# 1. Set up run -----
#----------------------------------------------------------#

library(here)

# Load configuration
source(
  here::here("R/00_Config_file.R"))


#----------------------------------------------------------#
# 2. Run individual parts -----
#----------------------------------------------------------#

working_dir <- 
  paste0(current_dir, #[config_criteria]
         "/R/01_Data_processing/01_Neotoma_source/")

# run if selected in Config file
if(neotoma_new_download == TRUE){
  
  download_confirm <- 
    fossilpol::util_confirm_based_on_presence(
      dir = paste0(data_storage_path, #[config_criteria]
                   "/Data/Input/Neotoma_download"),
      file_name = "neotoma_download",
      msg = paste("Detected previous download of Neotoma.",
                  "Are you sure you want to re-download?"))
  
  # download data
  if(download_confirm == TRUE){
    source(
      paste0(working_dir, "01_Download_neotoma.R"))
  }
  
}

source(
  paste0(working_dir, "02_Extract_samples.R"))

source(
  paste0(working_dir, "03_Filter_dep_env.R"))

source(
  paste0(working_dir, "04_Extract_chron_control_tables.R"))

source(
  paste0(working_dir, "05_Extract_raw_pollen_data.R"))
