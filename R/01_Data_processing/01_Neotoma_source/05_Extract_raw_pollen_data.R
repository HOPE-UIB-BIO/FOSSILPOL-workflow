#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow
#
#               Extract the raw pollen data
#
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon
#                         2023
#
#----------------------------------------------------------#

# Extract the raw pollen counts and filter by
#   selected variable element and selected ecological groups

#----------------------------------------------------------#
# 1. Set up  -----
#----------------------------------------------------------#

library(here)

# Load configuration
source(
  here::here("R/00_Config_file.R")
)

# set the current environment
current_env <- rlang::current_env()

RUtilpol::output_heading(
  msg = "Starting processing levels"
)


#----------------------------------------------------------#
# 2. Extract sample_depth   -----
#----------------------------------------------------------#

# load the data
RUtilpol::output_comment(
  msg = "Loading Neotoma chron control file"
)

neotoma_meta_chron_control <-
  RUtilpol::get_latest_file(
    file_name = "neotoma_meta_chron_control",
    dir = paste0(
      data_storage_path, # [config_criteria]
      "/Data/Processed/Neotoma_processed/Neotoma_chron_control"
    )
  )

# test the presence of data
RUtilpol::check_if_loaded(
  file_name = "neotoma_meta_chron_control",
  env = current_env
)

neotoma_sites_sample_depth <-
  RFossilpol::proc_neo_get_sample_depth(
    neotoma_meta_chron_control,
    min_n_levels # [config_criteria]
  )


#----------------------------------------------------------#
# 2. Raw counts and ecological groups  -----
#----------------------------------------------------------#

RUtilpol::output_heading(
  msg = "Preparing selection of ecological groups",
  size = "h2"
)

RUtilpol::output_comment(
  msg = paste(
    "For the explannation of ecological groups aberrations, please see\n",
    "'Technical guide to FOSSILPOL: The workflow to process",
    "global palaeoecological pollen data'"
  )
)

neotoma_counts <-
  RFossilpol::proc_neo_get_raw_counts(
    neotoma_sites_sample_depth,
    sel_var_element # [config_criteria]
  )


#----------------------------------------------------------#
# 3. Check the sample and count information  -----
#----------------------------------------------------------#

neotoma_processed <-
  RFossilpol::proc_neo_check_final_assembly(neotoma_counts)


#----------------------------------------------------------#
# 4. Save the data  -----
#----------------------------------------------------------#

RUtilpol::output_heading(
  msg = "Saving 'neotoma_processed'",
  size = "h2"
)

RUtilpol::save_latest_file(
  object_to_save = neotoma_processed,
  dir = paste0(
    data_storage_path, # [config_criteria]
    "/Data/Processed/Neotoma_processed"
  ),
  prefered_format = "rds",
  use_sha = TRUE
)
