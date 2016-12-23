#
#Md Johirul Islam
#ui.R
#

library(shiny)
library(plyr)
library(ggplot2)
library(leaflet)
# Define UI for application that draws a histogram
shinyUI(
  pageWithSidebar(
    headerPanel("FARS DATA: Demo With Year 2015"),
    sidebarPanel(
      selectInput(inputId="questions",
                  label="Questions",
                  choices = accidentQuestionList
                  )
    ),
    mainPanel(
      textOutput("textDisplay"),
      plotOutput("plot"),
      leafletOutput("map")
    )
  )
)
