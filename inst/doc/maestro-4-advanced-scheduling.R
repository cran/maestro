## ----echo=FALSE, warning=FALSE, message=FALSE---------------------------------
dir.create("pipelines")
writeLines(
  "
  # ./pipelines/daily_example.R
  #' daily_example maestro pipeline
  #'
  #' @maestroFrequency 1 day
  #' @maestroStartTime 2024-06-20 09:20:00
  daily_example <- function() {
  
    # Pipeline code
  }
  ",
  con = "pipelines/daily_example.R"
)

## ----eval=FALSE---------------------------------------------------------------
#  # ./pipelines/daily_example.R
#  #' daily_example maestro pipeline
#  #'
#  #' @maestroFrequency 1 day
#  #' @maestroStartTime 2024-06-20 09:20:00
#  daily_example <- function() {
#  
#    # Pipeline code
#  }

## -----------------------------------------------------------------------------
# ./orchestrator.R

library(maestro)

schedule <- build_schedule()

status <- run_schedule(
  schedule,
  orch_frequency = "1 day",
  check_datetime = as.POSIXct("2024-06-20 08:00:00", tz = "UTC")
)

## -----------------------------------------------------------------------------
# ./orchestrator.R
status <- run_schedule(
  schedule,
  orch_frequency = "15 minutes",
  check_datetime = as.POSIXct("2024-06-20 08:00:00", tz = "UTC")
)

## ----echo=FALSE---------------------------------------------------------------
data.frame(
  name = paste0("pipe", 1:3),
  frequency = c("1 hour", "2 days", "4 months"),
  start_time = as.POSIXct(c("2024-06-18 12:30:00", "2024-06-18 06:00:00", "2024-06-20 00:00:00"))
)

## ----echo=FALSE---------------------------------------------------------------
data.frame(
  name = paste0("pipe", 4:6),
  frequency = c("1 hour", "1 hour", "1 hour"),
  start_time = as.POSIXct(c("2024-06-18 00:00:00", "2024-06-18 00:10:00", "2024-06-18 00:20:00"))
)

## ----eval=FALSE---------------------------------------------------------------
#  #' specific_hours maestro pipeline
#  #'
#  #' @maestroFrequency hourly
#  #' @maestroHours 6 9 12 15 18
#  some_hours_example <- function() {
#  
#    # Pipeline code
#  }

## ----eval=FALSE---------------------------------------------------------------
#  #' specific_days_of_week maestro pipeline
#  #'
#  #' @maestroFrequency daily
#  #' @maestroDays Mon Tue Wed Thu Fri
#  some_dow_example <- function() {
#  
#    # Pipeline code
#  }
#  
#  #' specific_days_of_week maestro pipeline
#  #'
#  #' @maestroFrequency daily
#  #' @maestroDays 1 14 28
#  some_dom_example <- function() {
#  
#    # Pipeline code
#  }

## ----eval=FALSE---------------------------------------------------------------
#  #' specific_months maestro pipeline
#  #'
#  #' @maestroFrequency months
#  #' @maestroMonths 1 7 10
#  some_months <- function() {
#  
#    # Pipeline code
#  }

## ----eval=FALSE---------------------------------------------------------------
#  #' business_hours maestro pipeline
#  #'
#  #' @maestroFrequency hourly
#  #' @maestroHours 9 10 11 12 13 14 15 16 17
#  #' @maestroDays Mon Tue Wed Thu Fri
#  during_work_hours_example <- function() {
#  
#    # Pipeline code
#  }

## ----cleanup, echo=FALSE, message=FALSE, warning=FALSE------------------------
unlink("pipelines", recursive = TRUE)

