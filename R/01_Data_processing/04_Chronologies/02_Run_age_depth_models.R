#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow   
#
#                 Run the age depth models
#                 
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon 
#                         2021
#
#----------------------------------------------------------#

#  Run the Chronology age-depth models using parallel computing (batches). 
#   For batches, that do not successfully converge, run sequences individually
#   (this include writing problematic sequences into `Crash_file`)

#----------------------------------------------------------#
# 1. Set up  -----
#----------------------------------------------------------#

library(here)

# Load configuration
source(
  here::here("R/00_Config_file.R"))


#----------------------------------------------------------#
# 2.  Load data  -----
#----------------------------------------------------------#

full_chron_table <- 
  fossilpol:::chron_load_data_for_ad_modelling(
    data_storage_path #[config_criteria]
    )

#----------------------------------------------------------#
# 3.  Run age-depth modelling  -----
#----------------------------------------------------------#

chron_output <- 
  fossilpol::chron_recalibrate_ad_models(
    data_source = full_chron_table,
    batch_size = batch_size, #[config_criteria]
    number_of_cores = number_of_cores, #[config_criteria]
    default_iteration = default_iteration, #[config_criteria]
    default_burn = default_burn, #[config_criteria]
    default_thin = default_thin, #[config_criteria]
    iteration_multiplier = iteration_multiplier, #[config_criteria]
    set_seed = set_seed, #[config_criteria]
    dir = data_storage_path, #[config_criteria]
    batch_attemps = 3 # [USER] Number of tries each batch should be considered 
    # before skipping it
    )


#----------------------------------------------------------#
# 4. Save the data  -----
#----------------------------------------------------------#

fossilpol::util_output_comment(
  msg = "Saving temporary file. This can take time.")

readr::write_rds(
  chron_output,
  paste0(data_storage_path, #[config_criteria]
         "/Data/Processed/Chronology/Temporary_output/chron_output.rds"),
  compress = "gz")
