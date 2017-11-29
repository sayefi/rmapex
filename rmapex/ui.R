#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("My weather app"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(

         # em("Enter your city"),
       
       
       textInput("city",
                   "Enter Your City:",""),
       actionButton("okButton", "Enter"),
       tags$br(),
       tags$br(),
       em("Help"),
       helpText("Steps to use this app:"),
       helpText("1. Enter Name of your city (ie. Toronto)."),
       helpText("2. Press Enter."),
       helpText("3. Have fun...")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
         h3(paste("Today:",Sys.Date())),
     # plotOutput("distPlot")
     leafletOutput("map")
    )
  )
))
