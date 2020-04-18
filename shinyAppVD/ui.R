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
                menuItem("Age", tabName = "age", icon = icon("user-clock"))
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
                            box(width = 4,
                                title = "Correlation", status = "primary", solidHeader = TRUE, plotOutput("correlation"), 
                                sliderInput("controlsCorrelation", "Mesure de correlation", -1, 1, 0),
                            ),
                            box(width = 8,
                                title = "Secteurs", status = "danger", solidHeader = TRUE,
                                tabBox(width = 12,
                                       tabPanel(title = "Defensif", 
                                       plotlyOutput("defensif"),
                                       sliderInput("defensif", "Nombre d'observations", 1, 90, 45),
                                       ),
                                       tabPanel(title = "Offensif", 
                                        plotlyOutput("offensif"),
                                       )
                                )
                            )
                            
                        ),
                        fluidRow(
                            box(width = 4,
                                title = "Repartition des jouers par evaluation", status = "warning",solidHeader = TRUE, plotOutput("evaluation"),
                            ),
                            box(width = 8,
                                title = "Poste represent", status = "info",solidHeader = TRUE, plotOutput("represent"),
                            )
                        ),
                        fluidRow(
                            
                            box(
                                title = "Nombre de jouers", status = "primary", solidHeader = TRUE,
                                tabBox(width = 12,
                                       tabPanel(title = "Attaquant", 
                                                plotOutput("attaquant"),
                                       ),
                                       tabPanel(title = "Defenseurs", 
                                                plotOutput("defenseurs"),
                                       ),
                                       tabPanel(title = "Milieux", 
                                                plotOutput("milieux"),
                                       ),
                                       tabPanel(title = "Gardiens", 
                                                plotOutput("gardiens"),
                                       )
                                )
                            ),
                            box(
                                title = "La variable 'Age'", status = "danger", solidHeader = TRUE,
                                tabBox(width = 12,
                                       tabPanel(title = "Effectif ", 
                                                plotOutput("effectif"),
                                       ),
                                       tabPanel(title = "Moyenne", 
                                                plotOutput("moyenne"),
                                       ),
                                       tabPanel(title = "Nuage", 
                                                plotOutput("nuage"),
                                       )
                                )
                            ),
                            
                        )
                ),
                tabItem(tabName = "age",
                    fluidRow(
                        box(
                            title = "Pour le gardians", status = "primary", solidHeader = TRUE,
                            tabBox(
                                tabPanel(title = "1",
                                         plotOutput("1")
                                    
                                )
                            )
                        )
                    )
                )
            )
        ) 
    )
)