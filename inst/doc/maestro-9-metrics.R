## -----------------------------------------------------------------------------
#| echo: false
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


## -----------------------------------------------------------------------------
#| eval: false
# #' ./pipelines/metric_example.R
# #' @maestroFrequency 1 hour
# extract_flights <- function() {
# 
#   # Pretends to fetch data from an API
#   df <- data.frame(
#     flight_id = 1:5,
#     airline_code = c("UA", "AC", "AC", "AA", "DE"),
#     departure_time = as.POSIXct("2026-10-14 12:00:00") + c(100, 450, 750, 1450, 1750)
#   )
# 
#   update_metric("rows_read", nrow(df))
#   update_metric("bytes_read", as.numeric(object.size(df)))
# 
#   df
# }
# 
# #' @maestroInputs extract_flights
# load_flights <- function(.input) {
# 
#   write.csv(.input, tempfile(fileext = ".csv"))
# 
#   update_metric("rows_written", nrow(.input))
# }


## -----------------------------------------------------------------------------
#| echo: false
#| warning: false
#| message: false
invisible(unlink("pipelines", recursive = TRUE))
dir.create("pipelines")
writeLines(
  "
  #' @maestroFrequency 1 hour
  extract_flights <- function() {

    df <- data.frame(
      flight_id = 1:5,
      airline_code = c('UA', 'AC', 'AC', 'AA', 'DE'),
      departure_time = as.POSIXct('2026-10-14 12:00:00') + c(100, 450, 750, 1450, 1750)
    )

    update_metric('rows_read', nrow(df))
    update_metric('bytes_read', as.numeric(object.size(df)))

    df
  }

  #' @maestroInputs extract_flights
  load_flights <- function(.input) {

    write.csv(.input, tempfile(fileext = '.csv'))

    update_metric('rows_written', nrow(.input))
  }
  ",
  con = "pipelines/metric_example.R"
)


## -----------------------------------------------------------------------------
#| echo: true
library(maestro)

schedule <- build_schedule(quiet = TRUE)

status <- run_schedule(
  schedule,
  orch_frequency = "1 hour",
  quiet = TRUE
)

get_metrics(schedule)


## -----------------------------------------------------------------------------
#| echo: true
status <- run_schedule(
  schedule,
  orch_frequency = "1 hour",
  quiet = TRUE
)

get_metrics(schedule)


## -----------------------------------------------------------------------------
#| eval: false
# #' ./pipelines/metric_increment.R
# #' @maestroFrequency 1 day
# fetch_paginated <- function() {
# 
#   pages <- 1:3
#   results <- list()
# 
#   for (page in pages) {
#     attempts <- 0
#     repeat {
#       attempts <- attempts + 1
#       update_metric("attempts", 1, increment = TRUE)
# 
#       # Pretends to call an API that sometimes fails
#       ok <- runif(1) > 0.5
#       if (ok || attempts >= 3) break
#     }
# 
#     update_metric("api_calls", 1, increment = TRUE)
#     results[[page]] <- data.frame(page = page, value = rnorm(10))
#   }
# 
#   df <- do.call(rbind, results)
# 
#   # Overwriting (default) is fine for a one-off value
#   update_metric("rows_read", nrow(df))
# 
#   df
# }


## -----------------------------------------------------------------------------
#| echo: false
#| warning: false
#| message: false
invisible(unlink("pipelines", recursive = TRUE))
dir.create("pipelines")
writeLines(
  "
  #' @maestroFrequency 1 day
  fetch_paginated <- function() {

    pages <- 1:3
    results <- list()

    for (page in pages) {
      attempts <- 0
      repeat {
        attempts <- attempts + 1
        update_metric('attempts', 1, increment = TRUE)

        # Pretends to call an API that sometimes fails
        ok <- runif(1) > 0.5
        if (ok || attempts >= 3) break
      }

      update_metric('api_calls', 1, increment = TRUE)
      results[[page]] <- data.frame(page = page, value = rnorm(10))
    }

    df <- do.call(rbind, results)

    update_metric('rows_read', nrow(df))

    df
  }
  ",
  con = "pipelines/metric_increment.R"
)


## -----------------------------------------------------------------------------
#| echo: true
set.seed(2718)

schedule <- build_schedule(quiet = TRUE)

status <- run_schedule(
  schedule,
  orch_frequency = "1 day",
  quiet = TRUE
)

get_metrics(schedule)


## -----------------------------------------------------------------------------
#| echo: false
#| message: false
#| warning: false
invisible(unlink("pipelines", recursive = TRUE))

