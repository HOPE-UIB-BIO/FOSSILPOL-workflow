#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow
#
#           Predict the ages from Chronology models
#
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon
#                         2021
#
#----------------------------------------------------------#

#  Predict the ages from Chronology models. Select which data should be
#  predicted and save accordingly to settings (`calc_AD_models_denovo`,
#  `predict_ages_denovo`)

#----------------------------------------------------------#
# 1. Set up  -----
#----------------------------------------------------------#

library(here)

# Load configuration
source(
  here::here("R/00_Config_file.R")
)

RUtilpol::output_heading(
  msg = "Joining result of AD and predict ages for individual levels"
)

# [USER] here can user specify which dataset_ids should be re-run additionally
sites_to_rerun <- c()

#----------------------------------------------------------#
# 2. Load data to predict -----
#----------------------------------------------------------#

# load data
data_merged <-
  RUtilpol::get_latest_file(
    file_name = "data_merged",
    dir = paste0(
      data_storage_path, # [config_criteria]
      "/Data/Processed/Data_merged"
    )
  )

# test the presence of data
RUtilpol::check_if_loaded(
  file_name = "data_merged",
  env = current_env
)

#----------------------------------------------------------#
# 3.  Predicted new ages for each dataset  -----
#----------------------------------------------------------#

predicted_ages <-
  RFossilpol::chron_predict_all_ages(
    data_source = data_merged,
    dir = data_storage_path, # [config_criteria]
    predict_ages_denovo = predict_ages_denovo, # [config_criteria]
    sites_to_rerun = sites_to_rerun
  )


#----------------------------------------------------------#
# 4. Save the data  -----
#----------------------------------------------------------#

RUtilpol::save_latest_file(
  object_to_save = predicted_ages,
  dir = paste0(
    data_storage_path, # [config_criteria]
    "/Data/Processed/Chronology/Predicted_ages"
  ),
  prefered_format = "rds",
  use_sha = TRUE
)
