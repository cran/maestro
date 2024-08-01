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

## ----cleanup, echo=FALSE, message=FALSE, warning=FALSE------------------------
unlink("pipelines", recursive = TRUE)

