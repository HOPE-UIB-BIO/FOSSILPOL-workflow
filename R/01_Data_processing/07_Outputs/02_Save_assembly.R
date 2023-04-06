#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow
#
#             Produce the final data assembly
#
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon
#                         2023
#
#----------------------------------------------------------#

# Optionaly selecte the variables in the filtered data and save it


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


#----------------------------------------------------------#
# 2. Load data  -----
#----------------------------------------------------------#

data_filtered <-
  RUtilpol::get_latest_file(
    file_name = "data_filtered",
    dir = paste0(
      data_storage_path, # [config_criteria]
      "/Data/Processed/Data_filtered/"
    )
  )

# test the presence of data
RUtilpol::check_if_loaded(
  file_name = "data_filtered",
  env = current_env
)


#----------------------------------------------------------#
# 3. Save assembly  -----
#----------------------------------------------------------#

RFossilpol::proc_save_assembly(
  data_source = data_filtered,
  user_sel_variables = c("long", "lat"), # [USER] Here can user variables,
  # which have to be present in the  final data assembly (other can be selected
  # interactively, if `select_final_variables` is TRUE)
  select_final_variables = select_final_variables, # [config_criteria]
  dir = data_storage_path # [config_criteria]
)
