## ----eval = FALSE, message = FALSE, warning = FALSE---------------------------
# #' pipeline_wildfire_hourly maestro pipeline
# #'
# #' @maestroFrequency 3 hour
# #' @maestroStartTime 2024-04-25 05:45:00
# #' @maestroTz America/Halifax
# 
# 
# pipeline_wildfire_hourly <- function() {
# 
#   # load libraries
#   library(dplyr)
#   library(readr)
#   library(sf)
#   library(sfarrow)
# 
#   # Access active wildfire data from hosted csv
#   df <- readr::read_csv("https://cwfis.cfs.nrcan.gc.ca/downloads/activefires/activefires.csv")
# 
#   # Data wrangling
#   df_geom <- df |>
#     dplyr::mutate(insert_datetime = Sys.time()) |>
#     sf::st_as_sf(coords = c("lon", "lat"), crs = 4326)
# 
# 
#   # Write active wildfires to file
#   basename <- paste("cdn_wildfire", as.integer(Sys.time()), sep = "_")
# 
#   df_geom |>
#     sfarrow::write_sf_dataset("~/data/wildfires",
#                               format = "parquet",
#                               basename_template = paste0(basename,
#                                                          "-{i}.parquet"))
# }


## ----eval = FALSE, message = FALSE, warning = FALSE---------------------------
# #' pipeline_climate_daily maestro pipeline
# #'
# #' @maestroFrequency 1 day
# #' @maestroStartTime 2024-04-25 06:30:00
# #' @maestroTz America/Halifax
# 
# pipeline_climate_daily <- function() {
# 
#   # load libraries
#   library(dplyr)
#   library(httr2)
#   library(arrow)
# 
#   # Custom function for accessing api climate data
#   get_hourly_climate_info <- function(station_id, request_limit = 24) {
# 
#   # Validate parameters
#   stopifnot("`station_id` must be a real number" = is.numeric(station_id) && station_id > 0)
#   stopifnot("`station_id` must be a length-one vector" = length(station_id) == 1)
# 
#   # Access climate hourly via geomet api
#   hourly_req <- httr2::request("https://api.weather.gc.ca/collections/climate-hourly/items") |>
#     httr2::req_url_query(
#       lang = "en-CA",
#       offset = 0,
#       CLIMATE_IDENTIFIER = station_id,
#       LOCAL_DATE = Sys.Date() - 1,
#       limit = request_limit
#     )
# 
#   # Perform the request
#   hourly_resp <- hourly_req |>
#     httr2::req_perform()
# 
#   # Climate station response to data frame
#   geomet_json <- hourly_resp |>
#     httr2::resp_body_json(simplifyVector = TRUE)
# 
#   geomet_json$features
#   }
# 
#   # Write climate hourly to file
#   basename <- paste("climate_hourly", as.integer(Sys.time()), sep = "_")
# 
#   get_hourly_climate_info(8202251) |>
#     dplyr::mutate(insert_datetime = Sys.time()) |>
#     arrow::write_dataset(
#       "~/data/climate",
#       format = "parquet",
#       basename_template = basename
#       )
# }
# 

