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
                            box(width = 12,
                                title = tagList(shiny::icon("list"), "Summary"), status = "danger", solidHeader = TRUE, verbatimTextOutput("sum"),  
                            ),

                            
                        ),
                        fluidRow(
                            box(width = 4,
                                title = tagList(shiny::icon("chart-line"), "Correlation"), status = "primary", solidHeader = TRUE, plotOutput("correlation"), 
                            ),
                            box(width = 8,
                                title = tagList(shiny::icon("user-tag"), "Repartition par poste"), status = "warning", solidHeader = TRUE, plotOutput("repartition"),
                            )
                        )

 
                ),
                tabItem(tabName = "tables",
                        fluidRow(
                                valueBoxOutput("unoTable"),
                                valueBoxOutput("dosTable"),
                                valueBoxOutput("tresTable"),

                        ),

                        fluidRow(
                            box(
                                title = tagList(shiny::icon("arrows-alt"), "Gardiens"),
                                status = "warning",
                                solidHeader = TRUE,
                                DT::dataTableOutput("gardiens"),
                            ),
                            box(
                                title = tagList(shiny::icon("sort-amount-down"), "Defenseurs"),
                                status = "danger",
                                solidHeader = TRUE,
                                DT::dataTableOutput("defenseurs"),
                            ),
                        ),
                        fluidRow(
                            box(
                                title = tagList(shiny::icon("futbol"), "Milieux"),
                                status = "primary",
                                solidHeader = TRUE,
                                DT::dataTableOutput("milieux"),
                            ),
                            box(
                                title = tagList(shiny::icon("sort-amount-up"), "Attaquants"),
                                status = "success",
                                solidHeader = TRUE,
                                DT::dataTableOutput("attaquants"),
                            ),
                        ),
                        fluidRow(
                            downloadButton("data_football", "Download data_football.csv"),
                        )
                ),
                tabItem(tabName = "graphes",
                        fluidRow(
                            valueBoxOutput("graphesUno"),
                            valueBoxOutput("graphesDos"),
                            valueBoxOutput("graphesTres"),
                            
                        ),
                        fluidRow(
                          box(
                              title = tagList(shiny::icon("sort-amount-up"), "un"), status = "info", solidHeader = TRUE, plotOutput("EvalPlot"),
                              sliderInput('Slide1', 'Mex evaluation', min = 80, max = 100, value = 82)
                          ),
                          box(
                              title = tagList(shiny::icon("sort-amount-up"), "deux"), status = "warning", solidHeader = TRUE, plotOutput("myhist"),
                              selectInput('var1', "Select the Variable", choices = x, selected = 1),
                              br(),
                              sliderInput('Slide2', 'Mex evaluation', min = 82, max = 100, value = 82),
                          )
                        ),
                        fluidRow(
                            box(
                                title = tagList(shiny::icon("sort-amount-up"), "trois"), status = "danger", solidHeader = TRUE, plotOutput("myhistopos"),
                                selectInput('var2', "Select the Variable", choices = x, selected = 1),
                                br(),
                                sliderInput('Slide3', 'Evaluation', min = 82, max = 100, value = 82)
                            ),
                            box(
                                title = tagList(shiny::icon("sort-amount-up"), "quatre"), status = "success", solidHeader = TRUE,
                                tabBox(width = 12,
                                    tabPanel(title = "Gardien", 
                                             plotOutput("myhist1")
                                    ),
                                    tabPanel(title = "Defenseur", 
                                             plotOutput("myhist2")
                                    ),
                                    tabPanel(title = "Milieux", 
                                             plotOutput("myhist3")
                                    ),
                                    tabPanel(title = "Attaquant", 
                                             plotOutput("myhist4"),
                                    ),
                                    sliderInput('SlideTaille', 'Taille', min = 160, max = 200, value = 160),
                                    sliderInput('SlidePoids', 'Poids', min = 50, max = 100, value = 60)
                                ),
                                
                            ),

                        ),

                    
                )
            )
        ) 
    )
)