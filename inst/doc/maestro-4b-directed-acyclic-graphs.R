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
  #' @maestroFrequency daily
  get_letters <- function() {
    c('a', 'b', 'c')
  }

  #' @maestroInputs get_letters
  #' @maestroMap
  shout <- function(.input) {
    toupper(.input)
  }",
  con = "pipelines/fanout.R"
)

## ----eval=FALSE---------------------------------------------------------------
# #' @maestroFrequency daily
# get_letters <- function() {
#   c("a", "b", "c")
# }
# 
# #' @maestroInputs get_letters
# #' @maestroMap
# shout <- function(.input) {
#   toupper(.input)
# }

## ----echo=FALSE, warning=FALSE, message=FALSE---------------------------------
invisible(file.remove("pipelines/fanout.R"))
writeLines(
  "
  #' @maestroFrequency daily
  get_letters <- function() {
    list(
      letter = letters[1:3],
      greeting = 'hello'
    )
  }

  #' @maestroInputs get_letters
  #' @maestroMap .input$letter
  make_message <- function(.input) {
    paste(.input$greeting, toupper(.input$letter))
  }",
  con = "pipelines/fanout.R"
)

## ----eval=FALSE---------------------------------------------------------------
# #' @maestroFrequency daily
# get_letters <- function() {
#   list(
#     letter = letters[1:3],
#     greeting = "hello"
#   )
# }
# 
# #' @maestroInputs get_letters
# #' @maestroMap .input$letter
# make_message <- function(.input) {
#   paste(.input$greeting, toupper(.input$letter))
# }

## ----eval=FALSE---------------------------------------------------------------
# #' @maestroFrequency daily
# get_data <- function() {
#   list(
#     letter = letters[1:3],
#     greeting = c("hello", "cheers", "hi")
#   )
# }
# 
# #' @maestroInputs get_data
# #' @maestroMap .input$letter .input$greeting
# make_message <- function(.input) {
#   paste(.input$greeting, toupper(.input$letter))
# }

## ----echo=FALSE, warning=FALSE, message=FALSE---------------------------------
invisible(file.remove("pipelines/fanout.R"))
writeLines(
  "
  #' @maestroFrequency daily
  letter_a <- function() 'a'

  #' @maestroFrequency daily
  letter_b <- function() 'b'

  #' @maestroInputs collect(letter_a, letter_b)
  combine <- function(.input) {
    paste0(.input$letter_a, .input$letter_b)
  }",
  con = "pipelines/fanin.R"
)

## ----eval=FALSE---------------------------------------------------------------
# #' @maestroFrequency daily
# letter_a <- function() "a"
# 
# #' @maestroFrequency daily
# letter_b <- function() "b"
# 
# #' @maestroInputs collect(letter_a, letter_b)
# combine <- function(.input) {
#   paste0(.input$letter_a, .input$letter_b)
# }

## ----echo=FALSE, warning=FALSE, message=FALSE---------------------------------
invisible(file.remove("pipelines/fanin.R"))
writeLines(
  "
  #' @maestroFrequency daily
  numbers <- function() 1:3

  #' @maestroInputs numbers
  #' @maestroMap
  multiply <- function(.input) .input * 3

  #' @maestroInputs collect(multiply)
  add <- function(.input) {
    sum(unlist(.input))
  }",
  con = "pipelines/fanin.R"
)

## ----eval=FALSE---------------------------------------------------------------
# #' @maestroFrequency daily
# numbers <- function() 1:3
# 
# #' @maestroInputs numbers
# #' @maestroMap
# multiply <- function(.input) .input * 3
# 
# #' @maestroInputs collect(multiply)
# add <- function(.input) {
#   sum(unlist(.input))
# }

## ----cleanup2, echo=FALSE, message=FALSE, warning=FALSE-----------------------
invisible(unlink("pipelines", recursive = TRUE))

