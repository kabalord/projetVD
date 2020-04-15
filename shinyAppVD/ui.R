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

# Define UI for application that draws a histogram
shinyUI(
    dashboardPage(
        dashboardHeader(title = "APP Projet Visualisation de données"),
        dashboardSidebar(
            sidebarMenu(
                menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
                sliderInput(inputId = "slide", label = "label", min = 1, max = 7, value = 4)
            )
        ),
        dashboardBody(
            fluidRow(
                title = "Controls",
                mainPanel(
                    plotOutput("iris.graph")
                )
            )
        )
    )
)
