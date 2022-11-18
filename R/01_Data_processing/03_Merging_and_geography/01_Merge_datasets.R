#----------------------------------------------------------#
#
#
#                 The FOSSILPOL workflow
#
#                   Merge the datasets
#
#
#   O. Mottl, S. Flantua, K. Bhatta, V. Felde, A. Seddon
#                         2021
#
#----------------------------------------------------------#

# - Load the newest version of processed datasets from Neotoma
# and private sources.
# - Detect site duplicates among datasets.
# - Sort levels
# - Assign values based on geography.


#----------------------------------------------------------#
# 1. Set up  -----
#----------------------------------------------------------#

library(here)

# Load configuration
source(
  here::here("R/00_Config_file.R")
)


#----------------------------------------------------------#
# 2. Load the datasets  -----
#----------------------------------------------------------#

data_full <-
  RFossilpol::proc_get_merged_dataset(
    data_storage_path, # [config_criteria]
    private_data
  )


#----------------------------------------------------------#
# 4. Detect duplicates  -----
#----------------------------------------------------------#

# test for potential duplicated sequences between private data and Neotoma
if
(
  detect_duplicates == TRUE && private_data == TRUE # [config_criteria]
) {
  data_full_filtered <-
    RFossilpol::proc_filter_out_duplicates(
      data_source = data_full,
      data_storage_path = data_storage_path, # [config_criteria]
      filter_var = "source_of_data",
      n_subgroups = NULL,
      max_degree_distance = 1
    )
} else {
  data_full_filtered <- data_full
}


#----------------------------------------------------------#
# 6. Cleaning names -----
#----------------------------------------------------------#

# user can specify additional name changes [USER]

user_name_patterns <- NULL

# user_name_patterns <-
#   c("Taxon1" = "tax01",
#     "Taxon2" = "tax_02")

data_clean_names <-
  RFossilpol::proc_clean_count_names(
    data_source = data_full_filtered,
    additional_patterns = user_name_patterns
  )


#----------------------------------------------------------#
# 7. Cleaning levels -----
#----------------------------------------------------------#

data_sorted <-
  RFossilpol::proc_prepare_raw_count_levels(data_clean_names)


#----------------------------------------------------------#
# 6. Assign information based on geographical position -----
#----------------------------------------------------------#

# User can add additional layers as showed by the example
#
# Each layer has to have following data
#
#   1. var_name = name of the new variable for extracted data
#   2. sel_method = What is the format of the source of information
#     Could be either `shapefile` or `tif`
#   3. dir = Directory of the source of information.
#   4. file_name = Name of the layer for shapefile or tif file
#   5. var = Which variable should be extracted from source of information.
#     Note that it should be set as "raster_values" for tifs
#
# See more details `?geo_assign_value`
#
optional_info_to_assign <-
  tibble::tribble(
    ~var_name, ~sel_method, ~dir, ~file_name, ~var,

    ## Here is a space for user to add any additional information

    ## example of WWF biomes
    # "wwf_biome",
    # "shapefile",
    # paste0(current_dir, "/Data/Input/Spatial/Biomes_shapefile/WWF"),
    # "wwf_terr_biomes",
    # "BIOM_NAME"

    ## General shapefile example
    # "SELECTED NAME X",
    # "shapefile",
    # paste0(current_dir, "/Data/Input/Spatial/NAME_OF_FOLDER"),
    # "FILE_NAME X",
    # "VAR_NAME X"

    ## General TIF example
    # "SELECTED NAME Y",
    # "tif",
    # paste0(current_dir, "/Data/Input/Spatial/NAME_OF_FOLDER"),
    # "FILE_NAME_Y",
    # "VAR_NAME_Y"

    ## Each layer has to be separated by coma `,`
  )

data_geo <-
  RFossilpol::geo_assign_by_list(
    data_source = data_sorted,
    dir = current_dir, # [config criteria]
    optional_info_to_assign = optional_info_to_assign
  )

#----------------------------------------------------------#
# 7. Define regional age limits -----
#----------------------------------------------------------#

data_merged <-
  RFossilpol::proc_add_region_age_limits(
    data_source = data_geo,
    dir = data_storage_path # [config criteria]
  )

#----------------------------------------------------------#
# 13. Save -----
#----------------------------------------------------------#

RUtilpol::output_comment(
  msg = "Saving the data"
)

RUtilpol::save_latest_file(
  object_to_save = data_merged,
  dir = paste0(
    data_storage_path, # [config criteria]
    "/Data/Processed/Data_merged"
  ),
  prefered_format = "rds",
  use_sha = TRUE
)
