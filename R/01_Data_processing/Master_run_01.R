#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow 
#
#           Source all code for data processing steps
#                 
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon
#                         2021
#
#----------------------------------------------------------#

# Sources all individual processing steps in the folder of 
# 01_Data_processing.
# This include all steps from data sourcing, processing, to data output


#----------------------------------------------------------#
# 1. Set up run -----
#----------------------------------------------------------#

library(here)

# Load configuration
source(
  here::here("R/00_Config_file.R"))

#----------------------------------------------------------#
# 2. Run individual parts -----
#----------------------------------------------------------#

source(
  paste0(current_dir,
         "/R/01_Data_processing/",
         "01_Neotoma_source/Run_01_01.R"))

if(private_data == TRUE){
  source(
    paste0(current_dir,
           "/R/01_Data_processing/",
           "02_Private_source/Run_01_02.R")) 
}

source(
  paste0(current_dir, 
         "/R/01_Data_processing/",
         "03_Merging_and_geography/Run_01_03.R"))

source(
  paste0(current_dir, 
         "/R/01_Data_processing/",
         "04_Chronologies/Run_01_04.R"))

source(
  paste0(current_dir,
         "/R/01_Data_processing/",
         "05_Harmonisation/Run_01_05.R"))

source(
  paste0(current_dir, 
         "/R/01_Data_processing/",
         "06_Main_filtrering/Run_01_06.R"))

source(
  paste0(current_dir, 
         "/R/01_Data_processing/",
         "07_Outputs/Run_01_07.R"))
