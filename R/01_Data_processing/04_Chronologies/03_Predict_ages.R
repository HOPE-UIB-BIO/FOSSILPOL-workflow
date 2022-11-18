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

# load latest data with Chronology re-calibration
chron_output <-
  readr::read_rds(
    paste0(
      data_storage_path, # [config_criteria]
      "/Data/Processed/Chronology/Temporary_output/chron_output.rds"
    )
  )


#----------------------------------------------------------#
# 3. Prepare the data based on the previous results -----
#----------------------------------------------------------#

# check the current state and setting of chronology
current_state <-
  RFossilpol::chron_get_current_state(
    dir = data_storage_path, # [config_criteria]
    calc_AD_models_denovo = calc_AD_models_denovo,
    predict_ages_denovo = predict_ages_denovo
  )

# get the data to be predicted based on the current chronology result and
#   the current state and setting of chronology
data_to_predict <-
  RFossilpol::chron_prepare_ad_to_predict(
    data_source = chron_output,
    sites_to_rerun = sites_to_rerun,
    dir = data_storage_path, # [config_criteria]
    current_state = current_state
  )


#----------------------------------------------------------#
# 4.  Predicted new ages for each dataset  -----
#----------------------------------------------------------#

predicted_ages <-
  RFossilpol::chron_predict_all_ages(
    data_source = data_to_predict,
    dir = data_storage_path, # [config_criteria]
    date = current_date # [config_criteria]
  )


#----------------------------------------------------------#
# 4. Save the data  -----
#----------------------------------------------------------#

RFossilpol::chron_save_results(
  data_source_predicted_ages = predicted_ages,
  data_source_to_predict = data_to_predict,
  current_state = current_state,
  sites_to_rerun = sites_to_rerun,
  dir = data_storage_path # [config_criteria]
)
