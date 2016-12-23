#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plyr)
library(ggplot2)
library(leaflet)
library(scales)


accident2015<-datasrc$accident2015
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
 # output$textDisplay<-renderText({
  #  paste0("You Said '",input$comment,"'. There are ",nchar(input$comment),
   #        " characters in this ",states2015b[input$states])
#  })
  output$plot<-renderPlot({
    if(input$questions=="1")
    {
    accfreq<-count(accident2015,"STATE")
    temp<-accfreq$STATE
    accfreq$STATEs<-sapply(temp,function(x) toString(x))
    acc=data.frame(accfreq)
    acc$STATEs<-factor(acc$STATEs,statesCode)
    chart<-ggplot(acc, aes( x= STATEs, y=freq)) + geom_bar(stat="identity") + 
      labs(x="States", y="Incidents")+theme(axis.text.x=element_text(face = "bold",size="12",color="purple",angle = 90),
                                            axis.text.y=element_text(face="bold",color="red",size="16"))
    chart <- chart + scale_x_discrete(breaks = acc$STATEs,labels=states2015b[acc$STATEs])
      #scale_x_discrete(breaks=c(acc$STATE),labels=c(acc$STATE))
    }
    if(input$questions=="3")
    {
      accfreq<-count(accident2015,"MONTH")
      accfreq$MONTHs<-sapply(accfreq$MONTH,function(x) toString(x))
      #acc<-structure(list(States=sapply(accfreq[,1],function(x) states2015b[toString(x)]),Incidents=accfreq[,2]),.Names=c("States","Incidents"),class="data.frame")
      acc=data.frame(accfreq)
      acc$MONTHs<-factor(acc$MONTHs,levels=c("1","2","3","4","5","6","7","8","9","10","11","12"))
      acc<-cbind(acc,as.numeric(acc$MONTHs))
      #colnames()
      chart<-ggplot(acc, aes( x= MONTHs, y=freq,color=MONTHs)) + geom_bar(stat="identity") + 
        labs(x="Months", y="Incidents")+theme(axis.text.x=element_text(face = "bold",size="12",color="purple",angle = 90),
                                              axis.text.y=element_text(face="bold",color="red",size="16"))
      chart <- chart + scale_x_discrete(breaks = acc$MONTHs,labels=month.name)
      
    }
    if(input$questions=="4")
    {
      accfreq<-count(accident2015,"HOUR")
      accfreq$HOURs<-sapply(accfreq$HOUR,function(x) toString(x))
      #acc<-structure(list(States=sapply(accfreq[,1],function(x) states2015b[toString(x)]),Incidents=accfreq[,2]),.Names=c("States","Incidents"),class="data.frame")
      acc=data.frame(accfreq)
      acc$HOURs<-factor(acc$HOURs,levels=c("0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23"))
      #acc<-cbind(acc,as.numeric(acc$MONTHs))
      #colnames()
      chart<-ggplot(acc, aes( x= HOURs, y=freq,color=HOURs)) + geom_bar(stat="identity") + 
        labs(x="Hours", y="Incidents")+theme(axis.text.x=element_text(face = "bold",size="12",color="purple",angle = 90),
                                              axis.text.y=element_text(face="bold",color="red",size="16"))
      chart <- chart + scale_x_discrete(breaks = acc$HOURs,labels=acc$HOURs)
      
    }
    if(input$questions=="5")
    {
      accfreq<-count(accident2015,"DAY_WEEK")
      accfreq$DAY_WEEKs<-sapply(accfreq$DAY_WEEK,function(x) toString(x))
      #acc<-structure(list(States=sapply(accfreq[,1],function(x) states2015b[toString(x)]),Incidents=accfreq[,2]),.Names=c("States","Incidents"),class="data.frame")
      acc=data.frame(accfreq)
      acc$DAY_WEEKs<-factor(acc$DAY_WEEKs,levels=c("1","2","3","4","5","6","7"))
      #acc<-cbind(acc,as.numeric(acc$MONTHs))
      #colnames()
      chart<-ggplot(acc, aes( x= DAY_WEEKs, y=freq,color=DAY_WEEKs)) + geom_bar(stat="identity") + 
        labs(x="Days", y="Incidents")+theme(axis.text.x=element_text(face = "bold",size="12",color="purple",angle = 90),
                                             axis.text.y=element_text(face="bold",color="red",size="16"))
      chart <- chart + scale_x_discrete(breaks = acc$DAY_WEEKs,labels=week_days[acc$DAY_WEEKs])
    }
    print(chart)
  })
  points <- reactive({
    cbind(accident2015[0:400,]$LONGITUD, accident2015[0:400,]$LATITUDE)
          })
  
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addMarkers(data = points())
  })
  
})
