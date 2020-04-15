#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
data(iris)

dashboardPage(
    dashboardHeader(title = "Basic dashboard"),
    dashboardSidebar(),
    dashboardBody(
        # Boxes need to be put in a row (or column)
        fluidRow(
            box(plotOutput("plot1", height = 250)),
            
            box(
                title = "Controls",
                sliderInput("slider", "Number of observations:", 1, 100, 50)
            )
        )
    )
)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Old Faithful Geyser Data"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput(inputId = "slide", 
                        label = "label", 
                        min = 1, 
                        max = 7, 
                        value = 4),
            textInput(inputId = "title", 
                      label = "title",
                      value = "title"
            ),
            
            
        ),
        
        mainPanel(
            plotOutput("iris.graph")
        )
    )
)
)
