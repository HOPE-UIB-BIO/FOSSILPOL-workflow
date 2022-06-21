#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow
#
#                 Save the reference tables
#
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon
#                         2021
#
#----------------------------------------------------------#

# Save reference meta tables


#----------------------------------------------------------#
# 1. Set up -----
#----------------------------------------------------------#

library(here)

# Load configuration
source(
  here::here("R/00_Config_file.R")
)

# set the current environment
current_env <- rlang::current_env()

RFossilpol::util_output_message(
  msg = "Saving infomation about data assembly"
)


#----------------------------------------------------------#
# 2. Load data  -----
#----------------------------------------------------------#

data_assembly <-
  RFossilpol::util_load_latest_file(
    file_name = "data_assembly",
    dir = paste0(
      data_storage_path, # [config_criteria]
      "/Outputs/Data/"
    )
  )

# test the presence of data
RFossilpol::util_check_if_loaded(
  file_name = "data_assembly",
  env = current_env
)

# load dataset database
project_dataset_database <-
  readr::read_rds(
    paste0(
      data_storage_path, # [config_criteria]
      "/Data/Personal_database_storage/project_dataset_database.rds"
    )
  )


#----------------------------------------------------------#
# 3.  Save data assembly references -----
#----------------------------------------------------------#

RFossilpol::proc_save_references(
  data_source = data_assembly,
  project_database = project_dataset_database,
  user_sel_variables = c(), # [USER] Here can user select variables,
  # which have to be present in the  final data assembly
  dir = data_storage_path # [config_criteria]
)
