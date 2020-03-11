library(shiny)
library(leaflet)
library(datasets)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Locations of Earthquakes off Fiji"),
    
    #row of slider inputs
    fluidRow(
        column(6,
            sliderInput("depth",
                "Depth (km):",
                min = min(quakes$depth),
                max = max(quakes$depth),
                value = range(quakes$depth)
            ),
        ),
        column(6,
            sliderInput("mag",
                "Richter Magnitude:",
                 min = min(quakes$mag),
                 max = max(quakes$mag),
                 value = range(quakes$mag), step=0.1)
               
        ),
    
    #generate map
    leafletOutput("map")    
    )
))
