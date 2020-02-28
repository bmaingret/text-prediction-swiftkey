#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

source("predict.R")

shinyServer(function(input, output) {
  model <- readRDS("model1")

  observeEvent(input$predict, {
    output$predictions <- renderUI({
      predictions <- predict(input$testText, model)
      lapply(predictions, function(x) tags$li(x))
    })
  })
  
})
