## -----------------------------------------------------------------------------
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
    options(maestro.check_datetime_override = as.POSIXct("2026-04-21 03:00:00", tz = "UTC"))
    set.seed(1) 
  })
)

options(asciicast_theme = "pkgdown")

## -----------------------------------------------------------------------------
library(maestro)

## ----echo=FALSE, error=FALSE, warning=FALSE, message=FALSE--------------------
dir.create("pipelines")
writeLines(
  "
  #' my_pipe maestro pipeline
  #'
  #' @maestroFrequency 1 day
  #' @maestroStartTime 03:00:00
  #' @maestroTz UTC
  #' @maestroLogLevel INFO
  
  my_pipe <- function() {
  
    # Pipeline code
  }",
  con = "pipelines/my_pipe.R"
)

## ----eval=FALSE---------------------------------------------------------------
# #' my_pipe maestro pipeline
# #'
# #' @maestroFrequency 1 day
# #' @maestroStartTime 03:00:00
# #' @maestroTz UTC
# #' @maestroLogLevel INFO
# 
# my_pipe <- function() {
# 
#   # Pipeline code
# }

## -----------------------------------------------------------------------------
#' my_pipe maestro pipeline
#'
#' @maestroFrequency 1 day
#' @maestroStartTime 03:00:00
#' @maestroTz UTC
#' @maestroLogLevel INFO

my_pipe <- function() {

  random_data <- data.frame(
    letters = sample(letters, 10),
    numbers = sample.int(10)
  )
  
  write.csv(random_data, file = tempfile())
}

## ----example-pipe-------------------------------------------------------------
# create_pipeline(
#   pipe_name = "another_pipeline",
#   pipeline_dir = "pipelines",
#   frequency = "1 hour",
#   tz = "America/Halifax",
#   log_level = "ERROR"
# )

## ----cleanup, echo=FALSE, message=FALSE, warning=FALSE------------------------
unlink("pipelines", recursive = TRUE)

