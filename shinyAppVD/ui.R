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
library(dplyr)
library(tidyverse)
library(lattice)
library(car)
library(viridis)
library(GGally)
library(plotly)
library(ggcorrplot)
x <- levels(data.Football$Position)


# Define UI for application that draws a histogram
shinyUI(
    dashboardPage(skin = "green",
        dashboardHeader(title = "Football", dropdownMenuOutput("msgOutput"),
                        # dropdownMenu(type = "message",
                        #              # messageItem(from = "Clubs", message = "message clubs"),
                        #              # messageItem(from = "Jouers", message = "message jouers", icon = icon("futbol"), time = "19:44"),
                        #              # messageItem(from = "finances", message = "message finances", icon = icon("bar-chart"), time = "13-04-2020")
                        #              # )
                        
                        dropdownMenu(type = "notifications",
                                     notificationItem(
                                         text = "2 new tabs added to the dashboard",
                                         icon = icon("dashboard"),
                                         status = "success"
                                     ),
                                     notificationItem(
                                         text = "sever is currently running at 95% load",
                                         icon = icon("warning"),
                                         status = "warning"
                                     )
                        ),
                        dropdownMenu(type = "tasks",
                                     taskItem(
                                         value = 80,
                                         color = "aqua",
                                         "Shiny Dasboard Education"
                                     ),
                                     taskItem(
                                         value = 55,
                                         color = "red",
                                         "Overall R Education"
                                     ),
                                     taskItem(
                                         value = 40,
                                         color = "green",
                                         "Data Science Education"
                                     )
                        )
        ),
        dashboardSidebar(
            sidebarMenu(
                sidebarSearchForm("searchText", "buttonSearch", "Search"),
                menuItem("Accueil", tabName = "accueil", icon = icon("dashboard")),
                menuItem("Les tables", tabName = "tables", icon = icon("table")),
                menuItem("Les graphes", tabName = "graphes", icon = icon("chart-bar"))
            )
        ),
        dashboardBody(
            tabItems(
                tabItem(tabName = "accueil",
                        fluidRow(
                            valueBoxOutput("observations"),
                            valueBoxOutput("variables"),
                            valueBoxOutput("date"),
                        ),
                        fluidRow(
                             
                        ),
                        fluidRow(
                            box(width = 12,
                                title = "Summary", status = "danger", solidHeader = TRUE, verbatimTextOutput("sum"),  
                            ),

                            
                        ),
                        fluidRow(
                            box(width = 4,
                                title = "Correlation", status = "primary", solidHeader = TRUE, plotOutput("correlation"), 
                            ),
                            box(width = 8,
                                title = "Reparition par poste", status = "warning", solidHeader = TRUE, plotOutput("repartition"),
                            )
                        )

 
                ),
                tabItem(tabName = "tables",
 
                ),
                tabItem(tabName = "graphes",
                        fluidRow(
                          box(
                              title = "primière graph", status = "primary", solidHeader = TRUE, plotOutput("EvalPlot"),
                              sliderInput('Slide', 'Mex evaluation', min = 80, max = 100, value = 82)
                          ),
                          box(
                              title = "deuxième graph", status = "primary", solidHeader = TRUE, plotOutput("myhist"),
                              selectInput('var', "Select the Variable", choices = x, selected = 1),
                              br(),
                              sliderInput('Slide', 'Mex evaluation', min = 82, max = 100, value = 82),
                          )
                        ),
                        fluidRow(
                            box(
                                title = "troisième graph", status = "primary", solidHeader = TRUE, plotOutput("myhisto"),
                                selectInput('var', "Select the Variable", choices = x, selected = 1),
                                br(),
                                sliderInput('Slide', 'Mex evaluation', min = 82, max = 100, value = 82)
                            ),
                            box(
                                title = "quatrième graph", status = "primary", solidHeader = TRUE, 
                                plotOutput("myhist1"), 
                                plotOutput("myhist2"),
                                plotOutput("myhist3"),
                                plotOutput("myhist4"),
                                sliderInput('Slide', 'Taille', min = 160, max = 200, value = 160),
                                sliderInput('Slide2', 'Poids', min = 50, max = 100, value = 60)
                            )
                        )
                    
                )
            )
        ) 
    )
)