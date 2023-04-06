#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow
#
#             Create all the final outputs
#
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon
#                         2023
#
#----------------------------------------------------------#

# Cretae pollen diagrams, final data assembly and meta-informations

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
    "/R/01_Data_processing/07_Outputs/"
  )

source(
  paste0(working_dir, "01_Pollen_diagrams.R")
)

source(
  paste0(working_dir, "02_Save_assembly.R")
)

source(
  paste0(working_dir, "03_Save_references.R")
)
