#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow
#
#                     Chronologies
#
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon
#                         2021
#
#----------------------------------------------------------#

# Run all scripts in `/R/01_Data_processing/04_Chronologies/`
#   Prepare chronology control tables, run Bchon, and predict age for selected
#   sequences

#----------------------------------------------------------#
# 1. Set up run -----
#----------------------------------------------------------#

library(here)

# Load configuration
source(
  here::here("R/00_Config_file.R")
)


#----------------------------------------------------------#
# 2. Run individual parts -----
#----------------------------------------------------------#

working_dir <-
  paste0(
    current_dir, # [config_criteria]
    "/R/01_Data_processing/04_Chronologies/"
  )

# run if selected in Config file
if
(
  recalib_AD_models == TRUE
) { # [config_criteria]

  run_ad_confirm <-
    RFossilpol::util_confirm_based_on_presence(
      dir = paste0(
        data_storage_path, # [config_criteria]
        "/Data/Processed/Chronology/Predicted_ages"
      ),
      file_name = "chron_predicted_ages",
      msg = paste(
        "Detcted previous calculation of age-depth models.",
        "Are you sure you want to run age-depth modeling?"
      )
    )

  # download data
  if
  (
    run_ad_confirm == TRUE
  ) {
    source(
      paste0(
        working_dir,
        "01_Prepare_chron_control_tables.R"
      )
    )

    source(
      paste0(
        working_dir,
        "02_Run_age_depth_models.R"
      )
    )

    source(
      paste0(
        working_dir,
        "03_Predict_ages.R"
      )
    )

    source(
      paste0(
        working_dir,
        "04_Save_AD_figures.R"
      )
    )
  }
}

source(
  paste0(
    working_dir,
    "05_Merge_chron_output.R"
  )
)
