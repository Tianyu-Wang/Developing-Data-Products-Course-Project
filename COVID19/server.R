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
library(dplyr)
library(ggplot2)

# load data from github
data <- read.csv(url("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports_us/11-15-2020.csv")) %>% 
    filter(!is.na(Lat))


# Define server logic required to draw a map with COVID-19 data
shinyServer(function(input, output) {
    
    output$covidMap <- renderLeaflet({
        inputMetric <- input$metric
        labels <- c(
            "Confirmed" = "Confirmed Cases",
            "Deaths" = "Fatalities",
            "Incident_Rate" = "Incident Rate"
        )
        
        # filter data based on input$metric from ui.R
        plotdata <- data %>% 
            top_n(input$top_n, get(inputMetric))
        
        # initialize color palette based on input$metric from ui.R
        qpal <- colorQuantile("YlOrRd", plotdata[[inputMetric]], n = 9)
        
        # initialize label content based on input$metric from ui.R
        content <- paste(labels[inputMetric], ": ",
                         plotdata[[inputMetric]],
                         " (", plotdata$Province_State, ")"
        )
        
        # load map
        covidMap <- plotdata %>%
            leaflet() %>% 
            addTiles() %>% 
            addCircles(lng = ~Long_, lat = ~Lat, 
                       radius = ~sqrt(Confirmed)*300, 
                       color = qpal(plotdata[[inputMetric]]),
                       stroke = FALSE, 
                       fillOpacity = .5,
                       label = content
                       ) %>%
            setView(lat = 38.5266, lng = -96.7265, zoom = 3.5)
    })
})
