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

vars <- c(
    "Confirmed Cases" = "Confirmed",
    "Fatalities" = "Deaths",
    "Incident Rate" = "Incident_Rate"
)


# Define UI for application that draws a map with COVID-19 data
shinyUI(fluidPage(
    
    # Application title
    titlePanel("COVID-19 in the US Data (15.11.2020)"),
    
    # Sidebar with a slider input for the value range of confirmed cases
    sidebarLayout(
        sidebarPanel(
            selectInput("metric", "Select Metric for Bubble Color & Size:", vars, selected = "Confirmed"),
            sliderInput("top_n",
                            "Select Top N Value for Filtering:",
                            min = 0,
                            max = 60,
                            step = 1,
                            value = 20)
        ),
        
        # Show a plot of the generated map
        mainPanel(
            leafletOutput("covidMap")
        )
    )
))
