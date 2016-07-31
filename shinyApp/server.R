#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

## Packages required

library(shiny)
library(rCharts)
library(ggplot2)
require(reshape2)
library(dplyr)

## Load data needed

wd_2015_USF <- readRDS("wd_2015_US.rds")
us_summary <- readRDS("us_summary_2015.rds")
state_summary <- readRDS("state_summary_2015.rds")

## Load F and C variables for plotting

fy_vars <- c("FMAX", "FAVG", "FMIN")
cy_vars <- c("CMAX", "CAVG", "CMIN")
f_ymin <- -150
f_ymax <- 150
c_ymin <- -80
c_ymax <- 80
f_post <- " (F)"
c_post <- " (C)"

# Define server logic required 

shinyServer(function(input, output, session) {

## Observer for updating Location options based on the State selected
        
  observe({
    if(input$sel_state == "US") {
       updateSelectInput(session,
                         "sel_loc",
                         "Select Location",
                         c("------------------"=""))
    } else {  
    state_obs <- subset(wd_2015_USF, wd_2015_USF$state == input$sel_state)
                        
    loc_list <- state_obs %>%
                select(1, 15) %>%
                distinct
                        
    loc_list <- loc_list[order(loc_list$location) , ]
                        
    loc_list$location <- toupper(loc_list$location)

    stillSelected <- isolate(input$sel_loc[input$sel_loc %in% loc_list[,1]])
    
    updateSelectInput(session,
                      "sel_loc",
                      "Select Location",
                      c("Observation Location"="", structure(loc_list[,1], names=loc_list[,2])),
                      selected = stillSelected) }
                      
    })
        
        
  output$tempChart <- renderChart2({

## Create needed temp scale settings
          
    if(input$scale == "Fahrenheit")  { 
       y_vars <- fy_vars
       y_ymin <- f_ymin
       y_ymax <- f_ymax
       y_post <- f_post 
    } else {
       y_vars <- cy_vars
       y_ymin <- c_ymin
       y_ymax <- c_ymax
       y_post <- c_post       
    }

## Set proper data table for charting
          
    if(input$sel_state == "US") { ds_plot <- us_summary }
    
    if(input$sel_state != "US" && input$sel_loc == "") { ds_plot <- subset(state_summary, state_summary$state == input$sel_state) }
          
    if(input$sel_state != "US" && input$sel_loc != "") { ds_plot <- subset(wd_2015_USF, wd_2015_USF$Obs_Post == input$sel_loc) }

## Create tempChart

        uf1 <- mPlot(x = "Obs_Date",
                     y = y_vars,
                     type = "Line",
                     labels = c("Max Temp", "Avg Temp", "Min Temp"),
                     data = ds_plot)
          
        uf1$set(pointSize = 0,
                lineWidth = 1,
                ymin = y_ymin,
                ymax = y_ymax,
                postUnits = y_post,
                events = c("2015-1-1", "2015-2-1", "2015-3-1", "2015-4-1", "2015-5-1", "2015-6-1",
                           "2015-7-1", "2015-8-1", "2015-9-1", "2015-10-1", "2015-11-1", "2015-12-1","2015-12-31"),
                eventLineColors = "black",
                eventStrokeWidth = .5,
                lineColors = c("red", "green", "blue")) 
        
        return(uf1)
              })
  
})