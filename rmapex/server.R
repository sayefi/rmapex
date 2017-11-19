#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(owmr)

# install.packages("owmr")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  # output$distPlot <- renderPlot({
  #   
  #   # generate bins based on input$bins from ui.R
  #   x    <- faithful[, 2] 
  #   bins <- seq(min(x), max(x), length.out = input$bins + 1)
  #   
  #   # draw the histogram with the specified number of bins
  #   hist(x, breaks = bins, col = 'darkgray', border = 'white')
  #   
  #   
  #   
  #   
  # })
  # 
  
     # output$city<-renderText(input$city)
     
  observeEvent(input$okButton,{
       
       city<-input$city
       
       res <- get_current(city, units = "metric") %>%
            flatten()
       
       if(res$cod=="404"){
            return
       }
       
       popcontent <- paste(sep = "<br/>", 
                           paste("City:",res$name),
                           paste("Desc:",res$weather.main),
                           paste("Temp:",res$main.temp))
       
       
       output$map <- renderLeaflet({
            
            leaflet() %>% 
               addProviderTiles("Esri.WorldTopoMap") %>%
               setView(lng=res$coord.lon,lat=res$coord.lat, zoom = 5) %>%
               addPopups(lng=res$coord.lon,lat=res$coord.lat,
                                     popup = popcontent)
            
               # add_owm_tiles(api_key) %>%
               #  addMarkers(lng=res$coord.lon,lat=res$coord.lat,
               #              popup = paste(res$name,res$main.temp))%>%
               # setView(lng=res$coord.lon,lat=res$coord.lat, zoom = 10)
            
            
            # %>%
            #      
       })
  })
     
     output$map <- renderLeaflet({
          
          api_key<-"fdb99d731200dcf32a5f2b48463456f1"
          
          owmr::owmr_settings(api_key = api_key) 
          
          leaflet() %>% 
               # addTiles() %>%
               addProviderTiles("Esri.WorldTopoMap")
          }) 
 
  
})
