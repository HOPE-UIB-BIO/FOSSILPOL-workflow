#----------------------------------------------------------#
#
#
#                       Project name
#
#            Source all code for main analyses
#
#
#                         Names
#                         Year
#
#----------------------------------------------------------#

# Sources all or selected processing steps in the folder of
# `03_Main analyses`. These analyses are meant for the main output such as
# the most important figures and tables of analyses


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
  here::here(current_dir, "R/02_Main_analyses/")

# examples
# source(
#   here::here(
#     working_dir,
#     "01_Overview_maps/Run_02_01.R"))

# source(
#   here::here(
#     working_dir,
#     "02_Analyses_ABC/Run_02_02.R"))
