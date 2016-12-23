##############################################
##### minimal example for HTML- server.R #####
##############################################
library(shiny)
shinyServer(function(input, output) {
  output$textDisplay <- renderText({
    paste0("Title:'", input$comment, 
           "'. There are ",input$dist," graph ", nchar(input$comment),
           " characters in this."
    )
  })
  output$plotDisplay <- renderPlot({
    par(bg = "#ecf1ef") # set the background color
    plot(poly(1:100, as.numeric(input$dist)), type = "l",
         ylab="y", xlab="x")
  }) 
}) 