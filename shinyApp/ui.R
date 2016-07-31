#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(rCharts)

# Define UI for application 
shinyUI(fluidPage(
  
  # Application title
  titlePanel("U.S. Temperatures - 2015"),
  
  # Sidebar 
  sidebarLayout(
    sidebarPanel(
       radioButtons("scale",
                    "Temperature Scale",
                    choices = c("Fahrenheit", "Celsius"),
                    selected = "Fahrenheit"),
       
       hr(),
            
       selectInput("sel_state",
                   "Select State",
                   c("United States"="", "United States"="US", structure(state.abb, names=state.name)),
                   selected = "US",
                   multiple=FALSE),

       selectInput("sel_loc",
                   "Select Location",
                   c("------------------"=""),
                   multiple = FALSE)
      
    ),
    
    # Show a plot 
    mainPanel(
       showOutput("tempChart", lib = "morris")
    )
  )
))

