## ----eval = FALSE, message = FALSE, warning = FALSE---------------------------
# #' pipeline_wildfire_hourly maestro pipeline
# #'
# #' @maestroFrequency 3 hour
# #' @maestroStartTime 2024-04-25 05:45:00
# #' @maestroTz America/Halifax
# 
# pipeline_wildfire_hourly <- function() {
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
#   # Access climate hourly via geomet api
#   hourly_req <- httr2::request("https://api.weather.gc.ca/collections/climate-hourly/items") |>
#     httr2::req_url_query(
#       lang = "en-CA",
#       offset = 0,
#       CLIMATE_IDENTIFIER = 8202251,
#       LOCAL_DATE = Sys.Date() - 1
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
#   # Write climate hourly to file
#   basename <- paste("climate_hourly", as.integer(Sys.time()), sep = "_")
# 
#   geomet_json$features |>
#     dplyr::mutate(insert_datetime = Sys.time()) |>
#     arrow::write_dataset(
#       "~/data/climate",
#       format = "parquet",
#       basename_template = basename
#     )
# }
# 

