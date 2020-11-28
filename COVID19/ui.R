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
            h4("Description"),
            p("This Shiny app visualizes COVID-19 data in the US on an interactive map. It shows one of the following three metrics per state:"),
            p("- Confirmed Cases"),
            p("- Fatalities"),
            p("- Incident Rate (per 100k Persons)"),
            p("Circles are sized and colored by value of the chosen metric of interest. The app also allows you to filter for only the top N states with the highest values of the chosen metric (default: top 20 states with highest confirmed case count)."),
            p("(Data from November 15th 2020, source: ", a("Johns Hopkins University)", href="https://github.com/CSSEGISandData/COVID-19")),
            br(),
            h4("How to Use"),
            p("Use the ", strong("dropdown menu"), "to choose the metric of interest to be shown on the map:"),
            selectInput("metric", NULL, vars, selected = "Confirmed"),
            p("Use the ", strong("slider"), "to display only the top N states by chosen metric:"),
            sliderInput("top_n",
                            NULL,
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
