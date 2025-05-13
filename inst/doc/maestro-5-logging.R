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
#| echo: false
#| output: false
dir.create("pipelines")
writeLines(
  "
  #' @maestroFrequency hourly
  hello <- function() {
    message('hello')
  }
  
  #' @maestroFrequency hourly
  uhh <- function() {
    warning('this could be a problem')
  }
  
  #' @maestroFrequency hourly
  oh_no <- function() {
    stop('this is bad')
  }",
  con = "pipelines/logs.R"
)


## -----------------------------------------------------------------------------
#| eval: false
# #' pipelines/logs.R
# #' @maestroFrequency hourly
# hello <- function() {
#   message('hello')
# }
# 
# #' @maestroFrequency hourly
# uhh <- function() {
#   warning('this could be a problem')
# }
# 
# #' @maestroFrequency hourly
# oh_no <- function() {
#   stop('this is bad')
# }


## # orchestrator.R
## library(maestro)
## 
## schedule <- build_schedule(quiet = TRUE)
## 
## status <- run_schedule(
##   schedule,
##   run_all = TRUE,
##   log_to_file = TRUE
## )

## readLines("maestro.log")

## # orchestrator.R
## schedule <- build_schedule(quiet = TRUE)
## 
## status <- run_schedule(
##   schedule,
##   run_all = TRUE,
##   log_to_console = TRUE
## )

## -----------------------------------------------------------------------------
#| echo: false
#| output: false
file.remove("maestro.log")


## -----------------------------------------------------------------------------
#| echo: false
#| output: false
unlink("pipelines", recursive = TRUE)
dir.create("pipelines")
writeLines(
  "
  #' @maestroFrequency hourly
  #' @maestroLogLevel ERROR
  hello <- function() {
    message('hello')
  }
  
  #' @maestroFrequency hourly
  #' @maestroLogLevel ERROR
  uhh <- function() {
    warning('this could be a problem')
  }
  
  #' @maestroFrequency hourly
  #' @maestroLogLevel ERROR
  oh_no <- function() {
    stop('this is bad')
  }",
  con = "pipelines/logs.R"
)


## -----------------------------------------------------------------------------
#| eval: false
# #' pipelines/logs.R
# #' @maestroFrequency hourly
# #' @maestroLogLevel ERROR
# hello <- function() {
#   message('hello')
# }
# 
# #' @maestroFrequency hourly
# #' @maestroLogLevel ERROR
# uhh <- function() {
#   warning('this could be a problem')
# }
# 
# #' @maestroFrequency hourly
# #' @maestroLogLevel ERROR
# oh_no <- function() {
#   stop('this is bad')
# }


## # orchestrator.R
## schedule <- build_schedule(quiet = TRUE)
## 
## status <- run_schedule(
##   schedule,
##   run_all = TRUE,
##   log_to_console = TRUE
## )

## -----------------------------------------------------------------------------
#| echo: false
#| output: false
unlink("pipelines", recursive = TRUE)
dir.create("pipelines")
writeLines(
  "
  #' @maestroFrequency hourly
  hello <- function() {
    logger::log_info('hi', namespace = 'hello')
  }
  
  #' @maestroFrequency hourly
  uhh <- function() {
    logger::log_warn('this could be a problem', namespace = 'uhh')
  }
  
  #' @maestroFrequency hourly
  oh_no <- function() {
    logger::log_error('this is bad', namespace = 'oh_no')
  }",
  con = "pipelines/logs.R"
)


## -----------------------------------------------------------------------------
#| eval: false
# #' pipelines/logs.R
# #' @maestroFrequency hourly
# hello <- function() {
#   logger::log_info("hi", namespace = "hello")
# }
# 
# #' @maestroFrequency hourly
# uhh <- function() {
#   logger::log_warn("this could be a problem", namespace = "uhh")
# }
# 
# #' @maestroFrequency hourly
# oh_no <- function() {
#   logger::log_error("this is bad", namespace = "oh_no")
# }


## # orchestrator.R
## schedule <- build_schedule(quiet = TRUE)
## 
## status <- run_schedule(
##   schedule,
##   run_all = TRUE,
##   log_to_console = TRUE
## )

## ----cleanup------------------------------------------------------------------
#| echo: false
#| output: false
unlink("pipelines", recursive = TRUE)
file.remove("maestro.log")

