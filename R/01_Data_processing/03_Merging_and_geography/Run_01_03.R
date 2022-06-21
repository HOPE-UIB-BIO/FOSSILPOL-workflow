#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow
#
#                 Merge sources of data
#
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon
#                         2021
#
#----------------------------------------------------------#

# Run all scripts in `/R/01_Data_processing/03_Merging_and_geography/`

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
    current_dir, # [config criteria]
    "/R/01_Data_processing/03_Merging_and_geography/"
  )

source(
  paste0(working_dir, "01_Merge_datasets.R")
)
