## -----------------------------------------------------------------------------
#| eval: false
# library(cronR)
# library(here) # makes it easier to deal with path issues
# 
# cmd <- cron_rscript(
#   here("orchestrator.R"),
#   workdir = here()
# )
# 
# cron_add(
#   cmd,
#   frequency = "daily",
#   id = "maestro",
#   ask = FALSE
# )


## -----------------------------------------------------------------------------
#| eval: false
# library(taskscheduleR)
# library(here) # makes it easier to deal with path issues
# 
# taskscheduler_create(
#   taskname = "maestro",
#   rscript = here("orchestrator.R"),
#   schedule = "DAILY",
#   exec_path = here(),
#   startdate = format(Sys.Date() - 1, "%m/%d/%Y")
# )

