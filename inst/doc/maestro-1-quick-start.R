## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(maestro)

## -----------------------------------------------------------------------------
#' my_pipe maestro pipeline
#'
#' @maestroFrequency 1 day
#' @maestroStartTime 2024-05-24
#' @maestroTz UTC
#' @maestroLogLevel INFO

my_pipe <- function() {

  # Pipeline code
}

## -----------------------------------------------------------------------------
#' my_pipe maestro pipeline
#'
#' @maestroFrequency 1 day
#' @maestroStartTime 2024-05-24
#' @maestroTz UTC
#' @maestroLogLevel INFO

my_pipe <- function() {

  random_data <- data.frame(
    letters = sample(letters, 10),
    numbers = sample.int(10)
  )
  
  write.csv(random_data, file = tempfile())
}

## ----example-pipe, echo = TRUE, eval = FALSE, message = FALSE, warning = FALSE----
# create_pipeline(
#   pipe_name = "another_pipeline",
#   pipeline_dir = "pipelines",
#   frequency = "1 hour",
#   start_time = "2024-05-17 15:00:00",
#   tz = "America/Halifax",
#   log_level = "ERROR"
# )

## ----orch, echo = TRUE, eval = FALSE, message = FALSE, warning = FALSE--------
# library(maestro)
# 
# schedule <- build_schedule()
# 
# output <- run_schedule(
#   schedule,
#   orch_frequency = "1 hour"
# )

