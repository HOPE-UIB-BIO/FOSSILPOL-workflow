#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow
#
#         Apply taxonomic harmonisation based on
#                 regional tables
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon
#                         2023
#
#----------------------------------------------------------#

# Run all scripts in `/R/01_Data_processing/05_Harmonisation/`
#   Prepare all harmonisation tables and harmonise the raw counts


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
    "/R/01_Data_processing/05_Harmonisation/"
  )

source(
  paste0(working_dir, "01_Harmonisation.R")
)
