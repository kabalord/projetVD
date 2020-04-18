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
                menuSubItem("Clubs", tabName = "clubs"),
                menuSubItem("Jouers", tabName ="jouers" ),
                menuItem("Detailed Analysis", tabName = "detailed analysis", badgeLabel = "New", badgeColor = "green"),
                menuItem("Raw Data", tabName = "row data")
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
                            box(width = 12,
                                title = "Summary", status = "primary", solidHeader = TRUE, verbatimTextOutput("sum"), 
                            )
                            
                        ),
                ),
                tabItem(tabName = "clubs",
                        fluidRow(
                            valueBox(15*200, "last match", icon = icon("hourglass-3")),
                            valueBoxOutput("itemRequested")
                        ),
                        fluidRow(
                            column(width = 12,
                                   infoBox("Jouers force :", 1000, icon = icon("futbol")),
                                   infoBox("Club league :", "Calcio italiano", icon = icon("trophy")),
                                   infoBoxOutput("performance")
                            )
                        ),
                        fluidRow(
                            tabBox(
                                tabPanel(title = "première tab", h3("contenu première tab")
                                ),
                                tabPanel(title = "deuxième tab", h3("contenu deuxième tab")
                                )
                            )
                        )
                ),
                tabItem(tabName = "jouers",
                        h1("jouers tab")
                )
            )
        ) 
    )
)