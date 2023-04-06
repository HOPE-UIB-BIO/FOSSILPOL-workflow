#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow
#
#               Save figures of age-depth model
#
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon
#                         2023
#
#----------------------------------------------------------#

# Save all Chronology outputs as figures

#----------------------------------------------------------#
# 1. Set up  -----
#----------------------------------------------------------#

library(here)

# Load configuration
source(
  here::here("R/00_Config_file.R")
)

RUtilpol::output_heading(
  msg = "Saving all Chronology models as figures"
)


#----------------------------------------------------------#
# 2. Plot AD models  -----
#----------------------------------------------------------#

RFossilpol::chron_save_ad_figures(
  dir = data_storage_path, # [config_criteria]
  date = current_date, # [config_criteria]
  image_width = image_width, # [config_criteria]
  image_height = image_height, # [config_criteria]
  image_units = image_units, # [config_criteria]
  text_size = text_size, # [config_criteria]
  line_size = line_size # [config_criteria]
)
