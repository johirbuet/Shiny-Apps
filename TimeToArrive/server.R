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
source("accident.R")
source("person.R")
source("vehicle.R")
rm(list=ls())
datastr <- srcaccident$y2004
accidentdata <- read.dbf(datastr)
accidentdata <- read.dbf(datastr)
# Define server logic required to draw a histogram
tdiff <- function(hour1,minute1,hour2,minute2)
{
  minute=hour1*60+minute1 -(hour2*60+minute2)
  return(minute)
}
shinyServer(function(input, output) {
  
  # output$textDisplay<-renderText({
  #  paste0("You Said '",input$comment,"'. There are ",nchar(input$comment),
  #        " characters in this ",states2015b[input$states])
  #  })
  output$plot<-renderPlot({
    if(input$questions=="1")
    {
     # accfreq<-count(accidentdata,"STATE")
     # temp<-accfreq$STATE
      #accfreq$STATEs<-sapply(temp,function(x) toString(x))
      #acc=data.frame(accfreq)
      #acc$STATEs<-factor(acc$STATEs,statesCode)
      #chart<-ggplot(acc, aes( x= STATEs, y=freq)) + geom_bar(stat="identity") + 
       # labs(x="States", y="Incidents")+theme(axis.text.x=element_text(face = "bold",size="12",color="purple",angle = 90),
        #                                      axis.text.y=element_text(face="bold",color="red",size="16"))
      #chart <- chart + scale_x_discrete(breaks = acc$STATEs,labels=states2015b[acc$STATEs])
      #scale_x_discrete(breaks=c(acc$STATE),labels=c(acc$STATE))
      
     # accidentdata$diff<- tdiff(accidentdata$ARR_HOUR,accidentdata$ARR_MIN,accidentdata$NOT_HOUR,accidentdata$NOT_MIN)
      accidentdata<-accidentdata[accidentdata[,"ARR_HOUR"] != 99,]
      accidentdata<-accidentdata[accidentdata[,"NOT_HOUR"] != 99,]
      accidentdata<-accidentdata[accidentdata[,"NOT_MIN"] != 99,]
      accidentdata<-accidentdata[accidentdata[,"ARR_MIN"] != 99,]
      accidentdata$ARR_HOUR[accidentdata$ARR_HOUR==0]<-24
      accidentdata$NOT_HOUR[accidentdata$NOT_HOUR==0]<-24
      accidentdata$diff<- tdiff(accidentdata$ARR_HOUR,accidentdata$ARR_MIN,accidentdata$NOT_HOUR,accidentdata$NOT_MIN)
      accidentf<-aggregate(accidentdata$diff,by=list(STATE=accidentdata$STATE),FUN=mean)
      temp<-accidentf$STATE
      accidentf$STATEs<-sapply(temp,function(x) toString(x))
      acc=data.frame(accidentf)
      acc$STATEs<-factor(acc$STATEs,statesCode)
      chart<-ggplot(acc, aes( x= acc$STATEs, y=acc$x)) + geom_bar(stat="identity") + 
        labs(x="States", y="Incidents")+theme(axis.text.x=element_text(face = "bold",size="12",color="purple",angle = 90),
                                              axis.text.y=element_text(face="bold",color="red",size="16"))
      chart <- chart + scale_x_discrete(breaks = acc$STATEs,labels=states2015b[acc$STATEs])
    }
    if(input$questions=="3")
    {
      
      
    }
    if(input$questions=="4")
    {
    
      
    }
    if(input$questions=="5")
    {

    }
    print(chart)
  })
  points <- reactive({
    cbind(accidentdata[0:400,]$LONGITUD, accidentdata[0:400,]$LATITUDE)
  })
  
  
})
