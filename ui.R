library(shiny)
library(tools)
library(shinyjs)

dir <- "~/Desktop/phyto/photos/"
img_files <- list.files(dir, full.names = TRUE)

ui <- shinyUI(fluidPage(useShinyjs(),
  
  titlePanel("Phytoplankton ID Quiz"),
  
  
  mainPanel(
    plotOutput("plot",height=700),
    br(),
    br(),
    uiOutput("myBtn"),
    actionButton("btn1", label = ""),
    actionButton("btn2", label = ""),
    actionButton("btn3", label = ""),
    actionButton("btn4", label = ""),

    br(),
    br(),
    hidden(
      div(id='text_div',
    verbatimTextOutput("text"),
    )),
    br(),
    actionButton("next_btn", label = "Next"),
  )
 )
)
