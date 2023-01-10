#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow
#
#         Filter levels and sites by criteria
#
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon
#                         2021
#
#----------------------------------------------------------#

# Run all scripts in `/R/01_Data_processing/06_Main_filtrering/`
#   Filter out levels and records based on several criteria selected in
#   Config File

#----------------------------------------------------------#
# 1. Set up -----
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
    "/R/01_Data_processing/06_Main_filtrering/"
  )

source(
  paste0(working_dir, "01_Level_filtering.R")
)
