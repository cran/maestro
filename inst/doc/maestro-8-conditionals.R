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

## ----eval=FALSE---------------------------------------------------------------
# #' ./pipelines/conditional1.R
# #' @maestroFrequency 1 day
# #' @maestroRunIf sample(c(TRUE, FALSE), size = 1)
# random_execution <- function() {
#   message("Maybe, maybe not")
# }

## ----echo=FALSE, warning=FALSE, message=FALSE---------------------------------
invisible(unlink("pipelines", recursive = TRUE))
dir.create("pipelines")
writeLines(
  "
  #' @maestroFrequency 1 day
  #' @maestroRunIf TRUE
  random_execution <- function() {
    message('Maybe, maybe not')
  }",
  con = "pipelines/conditional1.R"
)

## ----eval=FALSE---------------------------------------------------------------
# #' ./pipelines/conditional2.R
# #' @maestroFrequency 1 hour
# extract_flights <- function() {
# 
#   # Pretends to fetch data from an API
#   data.frame(
#     flight_id = 1:5,
#     airline_code = c("UA", "AC", "AC", "AA", "DE"),
#     departure_time = as.POSIXct("2025-10-14 12:00:00") + c(100, 450, 750, 1450, 1750)
#   )
# }
# 
# #' @maestroInputs extract_flights
# #' @maestroRunIf
# #' is.data.frame(.input) && nrow(.input) > 0
# transform_flights <- function(.input) {
# 
#   proc_data <- .input
# 
#   proc_data <- proc_data |>
#     dplyr::filter(
#       flight_id > 5
#     ) |>
#     dplyr::mutate(
#       departing_from = "YHZ"
#     )
# 
#   proc_data
# }
# 
# #' @maestroInputs transform_flights
# #' @maestroRunIf
# #' is.data.frame(.input) && nrow(.input) > 0
# load_flights <- function(.input) {
# 
#   write.csv("flights.csv")
# }

## ----echo=FALSE, warning=FALSE, message=FALSE---------------------------------
invisible(unlink("pipelines", recursive = TRUE))
dir.create("pipelines")
writeLines(
  "
  #' ./pipelines/conditional1.R
  #' @maestroFrequency 1 hour
  extract_flights <- function() {
    
    # Pretends to fetch data from an API
    data.frame(
      flight_id = 1:5,
      airline_code = c('UA', 'AC', 'AC', 'AA', 'DE'),
      departure_time = as.POSIXct('2025-10-14 12:00:00') + c(100, 450, 750, 1450, 1750)
    )
  }

  #' @maestroInputs extract_flights
  #' @maestroRunIf 
  #' is.data.frame(.input) && nrow(.input) > 0
  transform_flights <- function(.input) {
    
    proc_data <- .input

    proc_data <- proc_data |> 
      dplyr::filter(
        flight_id > 5
      ) |> 
      dplyr::mutate(
        departing_from = 'YHZ'
      )

    proc_data
  }

  #' @maestroInputs transform_flights
  #' @maestroRunIf 
  #' is.data.frame(.input) && nrow(.input) > 0
  load_flights <- function(.input) {

    write.csv('flights.csv')
  }
  ",
  con = "pipelines/conditional2.R"
)

## ----eval=FALSE---------------------------------------------------------------
# #' ./pipelines/conditional3.R
# #' @maestroFrequency 1 day
# #' @maestroRunIf prod
# process_payments <- function() {
# 
#   # Some code that does important payment processing stuff
#   # but only in production!
# 
#   message("Payments processed")
# }

## ----echo=FALSE, warning=FALSE, message=FALSE---------------------------------
invisible(unlink("pipelines", recursive = TRUE))
dir.create("pipelines")
writeLines(
  "
  #' @maestroFrequency 1 day
  #' @maestroRunIf prod
  process_payments <- function() {
    
    # Some code that does important payment processing stuff 
    # but only in production!

    message('Payments processed')
  }",
  con = "pipelines/conditional3.R"
)

## ----cleanup, echo=FALSE, message=FALSE, warning=FALSE------------------------
invisible(unlink("pipelines", recursive = TRUE))

