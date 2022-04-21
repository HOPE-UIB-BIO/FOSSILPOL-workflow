#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow 
#
#           Prepare the chronology control tables 
#                 
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon 
#                         2021
#
#----------------------------------------------------------#

#  Prepare the chronology tables for age-depth modelling. Create the necessary 
#   calibration curves. Restructure chronology tables to fit Bchron package.
#    Fix issues with percentage carbon and assign post-bomb curve if necessary.  


#----------------------------------------------------------#
# 1. Set up  -----
#----------------------------------------------------------#

library(here)

# Load configuration
source(
  here::here("R/00_Config_file.R"))

# set the current environment
current_env <- rlang::current_env()

fossilpol::util_output_message(
  msg = "Starting preparing chronology control tables for AD modeling")

# Prepare calibration curves
fossilpol::chron_prepare_cal_curves()


#----------------------------------------------------------#
# 2. Load data  -----
#----------------------------------------------------------#

# load data
data_merged <-
  fossilpol::util_load_latest_file(
    file_name = "data_merged",
    dir = paste0(data_storage_path, #[config_criteria]
                 "/Data/Processed/Data_merged"))

# test the presence of data
fossilpol::util_check_if_loaded(
  file_name = "data_merged",
  env = current_env)

#----------------------------------------------------------#
# 3. Extract chronology control tables  -----
#----------------------------------------------------------#

chron_control_tables <- 
  fossilpol::chron_get_control_tables(
    data_source = data_merged,
    min_n_of_control_points = min_n_of_control_points #[config_criteria]
  )


#----------------------------------------------------------#
# 4. Check for presence of previous age-depth model outputs  -----
#----------------------------------------------------------#

chron_control_tables_subset <- 
  fossilpol::chron_subset_previous_sequences(
    data_source = chron_control_tables,
    dir = data_storage_path, #[config_criteria]
    rerun_ad = calc_AD_models_denovo, #[config_criteria]
    #[USER] here can user specify which dataset_ids should be re-run additionally
    sites_to_rerun = c() 
  )


#----------------------------------------------------------#
# 5. Chronology control point types  -----
#----------------------------------------------------------#

chron_control_types <- 
  fossilpol::chron_get_control_types(
    data_source = chron_control_tables_subset,
    dir = data_storage_path #[config_criteria]
  )


#----------------------------------------------------------#
# 6. Prepare data for age-depth modelling  -----
#----------------------------------------------------------#

chron_tables_prepared <- 
  fossilpol::chron_prepare_for_ad_modelling(
    data_source = chron_control_tables_subset,
    chron_control_types = chron_control_types,
    default_thickness = default_thickness, #[config_criteria]
    default_error = default_error, #[config_criteria]
    max_age_error = max_age_error, #[config_criteria]
    guess_depth = guess_depth, #[config_criteria]
    min_n_of_control_points = min_n_of_control_points, #[config_criteria]
    dir = data_storage_path #[config_criteria]
  )


#----------------------------------------------------------#
# 7. Save the data  -----
#----------------------------------------------------------#

fossilpol::util_save_if_latests(
  file_name = "chron_tables_prepared",
  dir = paste0(
    data_storage_path, #[config_criteria]
    "/Data/Processed/Chronology/Chron_tables_prepared"))
