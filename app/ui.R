#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(markdown)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    # Application title
    titlePanel("Word prediction"),
    navlistPanel(
        tabPanel("Word predictor",
            fluidRow(
                column(6, textInput("testText", tags$h3("Input"), "I never have"),
                       fluidRow(
                           column(12, tags$em("Input a sequence of words for which you wish to predict the next word"))),
                      fluidRow(
                           column(6, actionButton("predict", "Predict")))
                       ),
                column(6, fluidRow(tags$h3("Predictions")),
                            fluidRow(tags$ol(uiOutput('predictions'))))
            )),
        tabPanel("Documentation",
                 includeMarkdown("documentation.md"))
    )
))
