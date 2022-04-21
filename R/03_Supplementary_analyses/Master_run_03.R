#----------------------------------------------------------#
#
#
#                       Project name
#
#        Source all code for supplementary analyses
#                 
#
#                         Names 
#                         Year
#
#----------------------------------------------------------#

# Sources all or selected processing steps in the folder of 
# `02_Supplementary analyses`. These analyses are meant for output produced
# during the process of data handling and analyses that are important enough 
# to be save but not the main analyses performed. Examples are data checking
# coding, temporal figures, etc


#----------------------------------------------------------#
# 1. Set up run -----
#----------------------------------------------------------#

rm(list = ls())

# Load configuration
source("R/00_Config_file.R")


#----------------------------------------------------------#
# 2. Run individual parts -----
#----------------------------------------------------------#

working_dir <- 
  here::here(current_dir, "R/03_Supplementary_analyses/")

# examples
# source(
#   here::here(
#     working_dir,
#     "01_Overview_maps/Run_03_01.R"))

# source(
#   here::here(
#     working_dir,
#     "02_Missing_data_check/Run_03_02.R"))