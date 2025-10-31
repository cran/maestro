## ----echo=FALSE---------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = FALSE,
  comment = "",
  out.width = "100%",
  cache = FALSE,
  asciicast_knitr_output = "html"
)

asciicast::init_knitr_engine(
  echo = TRUE,
  echo_input = FALSE,
  same_process = TRUE,
  startup = quote({
    library(maestro)
    set.seed(1) 
  })
)
options(asciicast_theme = "pkgdown")

## ----echo=FALSE, warning=FALSE, message=FALSE---------------------------------
invisible(dir.create("pipelines"))
writeLines(
  "
  #' @maestroOutputs high_road low_road
  start <- function() {
    c('a', 'A')
  }
  
  #' @maestroInputs start
  high_road <- function(.input) {
    toupper(.input)
  }
  
  #' @maestroInputs start
  low_road <- function(.input) {
    tolower(.input)
  }",
  con = "pipelines/dags.R"
)

## ----eval=FALSE---------------------------------------------------------------
# #' ./pipelines/dags.R
# #' @maestroOutputs high_road low_road
# start <- function() {
#   c('a', 'A')
# }
# 
# #' @maestroInputs start
# high_road <- function(.input) {
#   toupper(.input)
# }
# 
# #' @maestroInputs start
# low_road <- function(.input) {
#   tolower(.input)
# }

## ----eval=FALSE---------------------------------------------------------------
# #' Example ETL pipeline
# #' @maestroFrequency 1 day
# #' @maestroStartTime 2024-03-25 12:30:00
# my_etl <- function() {
# 
#   # Pretend we're getting data from a source
#   message("Get data")
#   extracted <- mtcars
# 
#   # Transform
#   message("Transforming")
#   transformed <- extracted |>
#     dplyr::mutate(hp_deviation = hp - mean(hp))
# 
#   # Load - write to a location
#   message("Writing")
#   write.csv(transformed, file = paste0("transformed_mtcars_", Sys.Date(), ".csv"))
# }

## ----echo=FALSE, warning=FALSE, message=FALSE---------------------------------
invisible(file.remove("pipelines/dags.R"))
invisible(dir.create("pipelines"))
writeLines(
  "
  #' @maestroFrequency 1 day
  #' @maestroStartTime 2024-03-25 12:30:00
  #' @maestroOutputs transform
  extract <- function() {
    # Imagine this is something way more complicated, like a database call
    mtcars
  }
  
  #' @maestroOutputs load
  transform <- function(.input) {
    .input |> 
      dplyr::mutate(hp_deviation = hp - mean(hp))
  }
  
  #' @maestro
  load <- function(.input) {
    write.csv(.input, file = paste0('transformed_mtcars.csv'))
  }",
  con = "pipelines/etl.R"
)

## ----eval=FALSE---------------------------------------------------------------
# #' @maestroFrequency 1 day
# #' @maestroStartTime 2024-03-25 12:30:00
# #' @maestroOutputs transform
# extract <- function() {
#   # Imagine this is something way more complicated, like a database call
#   mtcars
# }
# 
# #' @maestroOutputs load
# transform <- function(.input) {
#   .input |>
#     dplyr::mutate(hp_deviation = hp - mean(hp))
# }
# 
# #' @maestro
# load <- function(.input) {
#   write.csv(.input, file = paste0("transformed_mtcars.csv"))
# }

## ----echo=FALSE, warning=FALSE, message=FALSE---------------------------------
library(maestro)

schedule <- build_schedule(quiet = TRUE)

show_network(schedule)

## ----cleanup, echo=FALSE, message=FALSE, warning=FALSE------------------------
invisible(unlink("pipelines", recursive = TRUE))
invisible(unlink("transformed_mtcars.csv"))

