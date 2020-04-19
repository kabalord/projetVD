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
        dashboardHeader(title = "Projet INFO0808", dropdownMenuOutput("msgOutput"),
                        dropdownMenu(type = "notifications",
                                     notificationItem(
                                         text = "Vous avez ajouté 2 nouveaux tabs",
                                         icon = icon("dashboard"),
                                         status = "success"
                                     ),
                                     notificationItem(
                                         text = "Votre application fonctione 100%",
                                         icon = icon("check-circle"),
                                         status = "success"
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
                menuItem("Accueil", tabName = "accueil", icon = icon("dashboard")),
                menuItem("Aperçu", tabName = "plots", icon = icon("chart-line")),
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
                                title = tagList(shiny::icon("list"), "Résumé dataset"), status = "danger", solidHeader = TRUE, verbatimTextOutput("sum"),  
                            ),

                            
                        ),
                        fluidRow(
                            box(width = 4,
                                title = tagList(shiny::icon("chart-line"), "Correlation des variables"), status = "primary", solidHeader = TRUE, plotOutput("correlation"), 
                            ),
                            box(width = 8,
                                title = tagList(shiny::icon("user-tag"), "Répartition des joueurs par poste"), status = "warning", solidHeader = TRUE, plotOutput("repartition"),
                            )
                        )
 
                ),
                tabItem(tabName = "plots",
                        fluidRow(
                            box(width = 4,
                                title = tagList(shiny::icon("arrows-alt"), "Répresentation Gardien"), status = "warning", solidHeader = TRUE, plotOutput("representationGardian"),
                            ),
                            box(width = 4,
                                title = tagList(shiny::icon("sort-amount-down"), "Répresentation Secteur Defensif"), status = "danger", solidHeader = TRUE, plotOutput("representationDefensif"),
                            ),
                            box(width = 4,
                                title = tagList(shiny::icon("futbol"), "Répresentation Secteur Offensif"), status = "success", solidHeader = TRUE, plotOutput("representationOffensif"),
                            )
                        ),
                        fluidRow(
                            box(
                                title = tagList(shiny::icon("balance-scale"), "Taille et Poids selon la position"), status = "success", solidHeader = TRUE,
                                tabBox(width = 12,
                                    tabPanel(title = "Gardien",
                                             plotOutput("poidsTailleGardien")
                                    ),
                                    tabPanel(title = "Defenseur",
                                             plotOutput("poidsTailleDefenseur")
                                    ),
                                    tabPanel(title = "Milieux",
                                             plotOutput("poidsTailleMilieux")
                                    ),
                                    tabPanel(title = "Attaquant",
                                             plotOutput("poidsTailleAttaquant")
                                    )
                                )
                            ),
                            box(
                                title = tagList(shiny::icon("user-clock"), "Évaluation de l'age selon la position"), status = "info", solidHeader = TRUE,
                                tabBox(width = 12,
                                       tabPanel(title = "Gardien",
                                                plotOutput("ageGardien")
                                       ),
                                       tabPanel(title = "Defenseur",
                                                plotOutput("ageDefenseur")
                                       ),
                                       tabPanel(title = "Milieux",
                                                plotOutput("ageMilieux")
                                       ),
                                       tabPanel(title = "Attaquant",
                                                plotOutput("ageAttaquant")
                                       )
                                )
                            ),
                        ),
                        fluidRow(
                            box(
                                title = tagList(shiny::icon("chart-line"), "Moyenne Pied Fort"), status = "info", solidHeader = TRUE, plotOutput("moyennePiedForte"),
                            ),
                            box(
                                title = tagList(shiny::icon("user-friends"), "Effectifs Pied Fort"), status = "warning", solidHeader = TRUE, plotOutput("effectifsPiedForte"),
                            )
                        ),
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
                            downloadButton("data_football", "Download data_football.csv"),
                        ),
                ),
                tabItem(tabName = "graphes",
                        fluidRow(
                          box(
                              title = tagList(shiny::icon("user-check"), "Repartition des joueurs par evaluation"), status = "danger", solidHeader = TRUE, plotOutput("EvalPlot"),
                              sliderInput('Slide1', 'Calification', min = 80, max = 100, value = 82)
                          ),
                          box(
                              title = tagList(shiny::icon("map-marked-alt"), "Position des joueurs par evaluation"), status = "warning", solidHeader = TRUE, plotOutput("myhist"),
                              selectInput('var1', "Select Position", choices = x, selected = 1),
                              br(),
                              sliderInput('Slide2', 'Calification', min = 82, max = 100, value = 82),
                          )
                        ),
                        fluidRow(
                            box(
                                title = tagList(shiny::icon("users"), "Effectifs des joueurs selon position"), status = "info", solidHeader = TRUE, plotOutput("myhistopos"),
                                selectInput('var2', "Select Position", choices = x, selected = 1),
                            ),
                            box(
                                title = tagList(shiny::icon("balance-scale"), "Effectifs des joueurs selon taille et poids"), status = "success", solidHeader = TRUE,
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