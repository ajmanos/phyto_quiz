library(shiny)
library(tools)
library(shinyjs)

#dir <- "~/Desktop/phyto/photos/"
img_files <- list.files(www, full.names = TRUE)

ui <- shinyUI(fluidPage(useShinyjs(),
  
  titlePanel("Phytoplankton ID Quiz"),
  
  
  mainPanel(
    #TODO: change height back to 700
    plotOutput("plot",height=600),
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


server <- function(input, output, session) {
  
  
  imgDisp <- reactiveValues(func = NULL)

  observeEvent(input$next_btn, {
    imgDisp$func <- sample(img_files,1)
  })
  
  
  
  
  imgName <- reactiveValues(func = NULL)
  
  observeEvent(input$next_btn, {
    imgName$func <- basename(file_path_sans_ext(imgDisp$func))
  })
  
  
  
  options <- reactiveValues(func = NULL)
  
  observeEvent(input$next_btn, {
    options$func <- basename(sample(c(imgName$func,sample(file_path_sans_ext(img_files),3))))
  })
  

  output$plot <- renderImage({
    validate(need(nchar(imgDisp$func)>0, "Click 'Next' to start the quiz!"))
    list(src = imgDisp$func,height=600,width=1000)
  }, deleteFile = FALSE)

    
  right <- "Correct!"
  wrong <- paste("Incorrect. The correct answer is")
  
  observe({
    req(input$next_btn)
    updateActionButton(session,"btn1", label = options$func[1])
    updateActionButton(session,"btn2", label = options$func[2])
    updateActionButton(session,"btn3", label = options$func[3])
    updateActionButton(session,"btn4", label = options$func[4])
  })


  observeEvent(input$next_btn, {
    toggle('text_div')
  })

  observeEvent(input$btn1, {
    toggle('text_div')
    if (options$func[1] == imgName$func){
      output$text <- renderText({right})
    } else {
      output$text <- renderText({c(wrong,imgName$func)})
    }
  })

  observeEvent(input$btn2, {
    toggle('text_div')
    if (options$func[2] == imgName$func){
      output$text <- renderText({right})
    } else {
      output$text <- renderText({c(wrong,imgName$func)})
    }
  })

  observeEvent(input$btn3, {
    toggle('text_div')
    if (options$func[3] == imgName$func){
      output$text <- renderText({right})
    } else {
      output$text <- renderText({c(wrong,imgName$func)})
    }
  })

  observeEvent(input$btn4, {
    toggle('text_div')
    if (options$func[4] == imgName$func){
      output$text <- renderText({right})
    } else {
      output$text <- renderText({c(wrong,imgName$func)})
    }
  })
  

  
}

shinyApp(ui, server)
