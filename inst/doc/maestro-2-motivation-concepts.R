## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)


## ----eval=FALSE---------------------------------------------------------------
# #' my_pipe maestro pipeline
# #'
# #' @maestroFrequency 1 day
# #' @maestroStartTime 2024-05-24
# 
# my_pipe <- function() {
# 
#   random_data <- data.frame(
#     letters = sample(letters, 10),
#     numbers = sample.int(10)
#   )
# 
#   write.csv(random_data, file = tempfile())
# }


## ----eval=FALSE---------------------------------------------------------------
# library(maestro)
# 
# schedule <- build_schedule()
# 
# run_schedule(
#   schedule,
#   orch_frequency = "1 hour"
# )

