#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow
#
#         Run all private data preparation scripts
#
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon
#                         2021
#
#----------------------------------------------------------#

# Run all scripts in `/R/01_Data_processing/02_Private_source/`

#----------------------------------------------------------#
# 1. Set up run -----
#----------------------------------------------------------#

library(here)

# Load configuration
source(
  here::here(
    "R/00_Config_file.R"
  )
)

#----------------------------------------------------------#
# 2. Run individual parts -----
#----------------------------------------------------------#

working_dir <-
  paste0(
    current_dir, # [config_criteria]
    "/R/01_Data_processing/02_Private_source/"
  )

if (private_data == TRUE) {
  source(
    paste0(working_dir, "01_Import_private_data.R")
  )
}
