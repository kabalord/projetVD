#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(dplyr)
library(tidyverse)
library(lattice)
library(car)
library(viridis)
library(GGally)
library(plotly)
library(ggcorrplot)

# Chargement dataset
data.Football <- fread(file="data_football.csv")

# Definition des variables
GARDIEN <- filter(data.Football,Position == "GARDIEN")
DEFENSEUR <- filter(data.Football,Position == c("DEFENSEUR GAUCHE") | Position == c("DEFENSEUR DROIT") |Position == c("DEFENSEUR CENTRE"))
MILIEUX <- filter(data.Football,Position == c("MILIEUX OFFENSIF") | Position == c("MILIEUX GAUCHE") |Position == c("MILIEUX DROIT") | Position == c("MILIEUX CENTRAL") | Position == c("MILIEUX DEFENSIF"))
ATTAQUANT <- filter(data.Football,Position == c("AILIER") | Position == c("ATTAQUANT"))


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    # correlation    
    output$correlation <- renderPlot({
        ggcorr(data.Football, breaks = input$controlsCorrelation)
    })
    
    # Secteurs
    
    output$defensif <- renderPlotly({
        ggplot(data = data.Football, breaks = input$defensif) + 
            geom_point(aes(x = Defense, y = Interception),color ="#35b779")
    })
    
    output$offensif <- renderPlotly({
        ggplot(data.Football) + 
            geom_point(aes(x = Attaque, y = Dribbles),color ="#35b779")
    })
    
    # repartition des jouers par evaluation
    
    output$evaluation <- renderPlot({
        ggplot(data.Football) +
            aes(x = Evaluation) +
            geom_histogram(fill ="#35b779", colour = "black",binwidth = .5) + 
            geom_rug() +
            ggtitle("Repartition des joueurs par evaluation") +
            xlab("Evaluation") +
            ylab("Effectif") +
            theme_light() +
            scale_y_continuous(limits = c(0,25))
    })
    
    output$represent <- renderPlot({
        ggplot(data = data.Football) + 
            geom_histogram(aes(x = Evaluation),binwidth=.5,fill ="#35b779", colour = "black") + 
            facet_wrap(~Position)
    })
    
    # value boxes accueil
    output$observations <- renderValueBox({
        valueBox(
            nrow(data.Football), icon = icon("list"), "Observations", color = "purple")
    })
    
    output$variables <- renderValueBox({
        valueBox(
            ncol(data.Football), icon = icon("columns"), "Variables", color = "yellow")
    })
    
    output$date <- renderValueBox({
        valueBox(2017, icon = icon("calendar"),"Date d'analyse", color = "light-blue")
    })
    
    
    # nombre de jouers 
    
    output$gardiens <- renderPlot({
        GARDIEN
        ggplot(GARDIEN) + geom_bar(aes(x = Position),fill ="#35b779", colour = "black") + 
            scale_x_discrete("Position") +
            labs(x = "Position", y = "Effectif", title = "Nombre de gardiens") +
            theme_gray()
    })
    
    output$defenseurs <- renderPlot({
        DEFENSEUR
        ggplot(DEFENSEUR) + geom_bar(aes(x = Position),fill ="#35b779", colour = "black") + 
            scale_x_discrete("Position") +
            labs(x = "Position", y = "Effectif", title = "Nombre de defenseurs") +
            theme_gray()
    })
    
    output$milieux <- renderPlot({
        MILIEUX
        ggplot(MILIEUX) + geom_bar(aes(x = Position),fill ="#35b779", colour = "black") + 
            scale_x_discrete("Position") +
            labs(x = "Position", y = "Effectif", title = "Nombre de milieux") +
            theme_gray()
    })
    
    output$attaquant <- renderPlot({
        ATTAQUANT
        ggplot(ATTAQUANT) + geom_bar(aes(x = Position),fill ="#35b779", colour = "black") + 
            scale_x_discrete("Position") +
            labs(x = "Position", y = "Effectif", title = "Nombre d'attaquant") +
            theme_gray()
    })
    
    # la variable age 
    
    output$effectif <- renderPlot({
        ggplot(data.Football) +
            aes(x = Age) +
            geom_histogram(fill ="#35b779", colour = "black",binwidth = .5) + 
            geom_rug() +
            ggtitle("Repartition des joueurs par evaluation") +
            xlab("Age") +
            ylab("Effectif") +
            scale_y_continuous(limits = c(0,25))
    })
    
    output$moyenne <- renderPlot({
        ggplot(data.Football) + 
            geom_boxplot(aes(x = Evaluation, y = Age), fill = "#35b779", color = "black")
    })
    
    output$nuage <- renderPlot({
        ggplot(data.Football) + 
            geom_point(aes(x = Age, y = Evaluation), 
                       color = "#35b779", size = 2)
    })
    
    output$msgOutput <- renderMenu({
        msgs <- apply(read.csv("messages.csv"), 1, function(row){
            messageItem(from = row[["from"]], message = row[["message"]])
        })
        dropdownMenu(type = "messages", .list = msgs)
    })
    
    output$performance <- renderInfoBox({
        infoBox("Performance :", "100%", icon = icon("chart-bar"))
    })
    
    output$itemRequested <- renderValueBox({
        valueBox(15*300, "Item Request by Jouers", icon = icon("fire"), color = "yellow")
    })
})
