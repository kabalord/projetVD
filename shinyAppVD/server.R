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
Gaucher <- filter(data.Football,Pied_Fort == "GAUCHE")
Droitier <- filter(data.Football,Pied_Fort == "DROIT")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    # correlation    
    output$correlation <- renderPlot({
        ggcorr(data.Football, breaks = input$controlsCorrelation)
    })
    
    # Secteurs
    
    output$defensif <- renderPlotly({
        ggplot(data.Football, breaks = input$defensif) + 
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
    
    output$pointsGardians <- renderPlot({
        ggplot(GARDIEN) + 
            geom_point(aes(x = Age, y = Evaluation), 
                       color = "#35b779", size = 2)
    })
    
    output$textGardians <- renderPlot({
        ggplot(GARDIEN) + 
            geom_text(aes(x = Age, y = Evaluation, label = Nom), 
                      color = "#35b779", size = 5)
    })
    
    output$pointsDefenseurs <- renderPlot({
        ggplot(DEFENSEUR) + 
            geom_point(aes(x = Age, y = Evaluation), 
                       color = "#35b779", size = 2)
    })
    
    output$textDefenseurs <- renderPlot({
        ggplot(DEFENSEUR) + 
            geom_text(aes(x = Age, y = Evaluation, label = Nom), 
                      color = "#35b779", size = 5)
    })
    
    output$pointsMilieux <- renderPlot({
        ggplot(MILIEUX) + 
            geom_point(aes(x = Age, y = Evaluation), 
                       color = "#35b779", size = 2)
    })
    
    output$textMilieux <- renderPlot({
        ggplot(MILIEUX) + 
            geom_text(aes(x = Age, y = Evaluation, label = Nom), 
                      color = "#35b779", size = 5)
    })
    
    output$pointsAttaquants <- renderPlot({
        ggplot(ATTAQUANT) + 
            geom_point(aes(x = Age, y = Evaluation),
                       color = "#35b779", size = 2)
    })
    
    output$textAttaquants <- renderPlot({
        ggplot(ATTAQUANT) + 
            geom_text(aes(x = Age, y = Evaluation, label = Nom), 
                      color = "#35b779", size = 5)
    })
    
    
    # la variable pied fort
    
    output$piedMoyenne <- renderPlot({
        ggplot(data.Football) +
            geom_boxplot(aes(x = Pied_Fort, y = Evaluation)) + 
            geom_jitter(aes(x = Pied_Fort, y = Evaluation), col = "#35b779", alpha = 1)
     
    })
    
    
    output$attaqueGauche <- renderPlot({
    
        ggplot(data = data.Football, aes(x = Attaque, y = Evaluation)) + 
            geom_point(alpha = 0.2) + 
            geom_text(data = Gaucher, aes(label = Nom), color = "#35b779", size = 5)
    })
    
    
    output$attaqueDroit <- renderPlot({
        ggplot(data = data.Football, aes(x = Attaque, y = Evaluation)) + 
            geom_point(alpha = 0.2) + 
            geom_text(data = Droitier, aes(label = Nom), color = "#35b779", size = 5)
    })
    
    
    output$gardienMoyenne <- renderPlot({
        filter(GARDIEN[c(1,4,8)],Pied_Fort == "GAUCHE")
        filter(GARDIEN[c(1,4,8)],Pied_Fort == "DROIT")
        
        ggplot(GARDIEN) +
            geom_boxplot(aes(x = Pied_Fort, y = Evaluation)) + 
            labs(x = "Pied fort", y = "Evaluation", title = "Gardiens") +
            geom_jitter(aes(x = Pied_Fort, y = Evaluation), col = "#35b779", alpha = 1) 
    })
    
    output$gardienGauche <- renderPlot({
        filter(GARDIEN[c(1,4,8)],Pied_Fort == "GAUCHE")
        filter(GARDIEN[c(1,4,8)],Pied_Fort == "DROIT")
        
        ggplot(data = GARDIEN, aes(x = Competence_Gardien, y = Evaluation)) + 
            geom_point(alpha = 0.2) + 
            labs(x = "Defense", y = "Evaluation", title = "Gardiens") +
            geom_text(data = filter(GARDIEN,Pied_Fort == "GAUCHE"), aes(label = Nom), color = "#35b779", size = 5)
    })
    
    output$gardienDroit <- renderPlot({
        filter(GARDIEN[c(1,4,8)],Pied_Fort == "GAUCHE")
        filter(GARDIEN[c(1,4,8)],Pied_Fort == "DROIT")
        
        ggplot(data = GARDIEN, aes(x = Competence_Gardien, y = Evaluation)) + 
            geom_point(alpha = 0.2) + 
            labs(x = "Defense", y = "Evaluation", title = "Gardiens") +
            geom_text(data = filter(GARDIEN,Pied_Fort == "DROIT"), aes(label = Nom), color = "#35b779", size = 5)
    })
    
    
    output$defenseurMoyenne <- renderPlot({
        filter(DEFENSEUR[c(1,4,8)],Pied_Fort == "GAUCHE")
        filter(DEFENSEUR[c(1,4,8)],Pied_Fort == "DROIT")
        
        ggplot(DEFENSEUR) +
            geom_boxplot(aes(x = Pied_Fort, y = Evaluation)) + 
            labs(x = "Pied fort", y = "Evaluation", title = "Defenseurs") +
            geom_jitter(aes(x = Pied_Fort, y = Evaluation), col = "#35b779", alpha = 1) 
    })
    
    output$defenseurpiefort <- renderPlot({
        filter(DEFENSEUR[c(1,4,8)],Pied_Fort == "GAUCHE")
        filter(DEFENSEUR[c(1,4,8)],Pied_Fort == "DROIT")
        
        ggplot(data = DEFENSEUR, aes(x = Defense, y = Evaluation)) + 
            geom_point(alpha = 0.2) + 
            labs(x = "Defense", y = "Evaluation", title = "Defenseurs") +
            geom_text(data = filter(DEFENSEUR,Pied_Fort == "GAUCHE"), aes(label = Nom), color = "#35b779", size = 2)
    })
    
    output$milieuxMoyenne <- renderPlot({
        filter(MILIEUX[c(1,4,8)],Pied_Fort == "GAUCHE")
        filter(MILIEUX[c(1,4,8)],Pied_Fort == "DROIT")
        
        ggplot(MILIEUX) +
            geom_boxplot(aes(x = Pied_Fort, y = Evaluation)) + 
            labs(x = "Pied fort", y = "Evaluation", title = "Milieux") +
            geom_jitter(aes(x = Pied_Fort, y = Evaluation), col = "#35b779", alpha = 1) 
        
    })
    
    output$milieuxMoyenne <- renderPlot({
        filter(MILIEUX[c(1,4,8)],Pied_Fort == "GAUCHE")
        filter(MILIEUX[c(1,4,8)],Pied_Fort == "DROIT")
        
        geom_boxplot(aes(x = Pied_Fort, y = Evaluation)) + 
            labs(x = "Pied fort", y = "Evaluation", title = "Milieux") +
            geom_jitter(aes(x = Pied_Fort, y = Evaluation), col = "#35b779", alpha = 1) 
    })
    
    output$milieuxpiefort <- renderPlot({
        filter(MILIEUX[c(1,4,8)],Pied_Fort == "GAUCHE")
        filter(MILIEUX[c(1,4,8)],Pied_Fort == "DROIT")
        
        ggplot(MILIEUX) +

        ggplot(data = MILIEUX, aes(x = Passe, y = Evaluation)) + 
            geom_point(alpha = 0.2) + 
            labs(x = "Passe", y = "Evaluation", title = "Milieux") +
            geom_text(data = filter(MILIEUX,Pied_Fort == "GAUCHE"), aes(label = Nom), color = "#35b779", size = 2)
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
