library(shiny)
library(leaflet)
library(datasets)

#define server logic
shinyServer(function(input, output, session) {
    
    #filter data based on inputs
    x <- reactive({
        quakes[quakes$depth >= input$depth[1] & quakes$depth <= input$depth[2] &
                   quakes$mag >= input$mag[1] & quakes$mag <= input$mag[2],]})
    
    #render permanent aspects of plot
    output$map<- renderLeaflet({
        leaflet(x()) %>% addTiles() %>%
            fitBounds(~min(long), ~min(lat), ~max(long), ~max(lat))
    })
    
    #listen for incremental changes to the map
    observe({
        leafletProxy("map", data=x()) %>%
            clearMarkers() %>%
            addCircleMarkers(color="#777777", radius=~sqrt(depth), popup=~paste("Magnitude:", mag, ", Depth:", depth),
                             clusterOptions = markerClusterOptions())
    })
})
