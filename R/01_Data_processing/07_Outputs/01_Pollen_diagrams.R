#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow 
#
#                   Save pollen diagrams
#                 
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon 
#                         2021
#
#----------------------------------------------------------#

# Save pollen diagrams for all sequences presented after filtration


#----------------------------------------------------------#
# 1. Set up -----
#----------------------------------------------------------#

library(here)

# Load configuration
source(
  here::here("R/00_Config_file.R"))

# set the current environment
current_env <- rlang::current_env()

RFossilpol::util_output_message(
  msg = "Start creation of pollen diagrams")


#----------------------------------------------------------#
# 2. Load data  -----
#----------------------------------------------------------#

data_filtered <- 
  RFossilpol::util_load_latest_file(
    file_name = "data_filtered",
    dir = paste0(data_storage_path, #[config_criteria]
                 "/Data/Processed/Data_filtered/"))

# test the presence of data
RFossilpol::util_check_if_loaded(
  file_name = "data_filtered",
  env = current_env)


#----------------------------------------------------------#
# 3. Plot all pollen diagrams -----
#----------------------------------------------------------#

RFossilpol::plot_all_pollen_diagrams(
  data_source = data_filtered,
  dir = data_storage_path, #[config_criteria]
  min_n_occur = 3, # [USER] Here, user can select min number of occurrence 
  # of taxa to be displayed
  max_taxa = 20,  # [USER] Here, user can select number of taxa to plotted 
  # per one page 
  y_var = "age",# [USER] Here, user can select if y-axis should be "age" or 
  # "depth"
  date = current_date #[config_criteria]
)


